//
//  Network.swift
//  Core
//
//  Created by 한상진 on 2022/03/25.
//  Copyright © 2022 havi. All rights reserved.
//

import Foundation

public protocol NetworkRepository {
    func reqeust<Model: Decodable>(
        with endpoint: EndpointType, 
        for type: Model.Type
    ) async throws -> Model
} 

public struct NetworkRepositoryImpl: NetworkRepository {
    
    private let session: URLSessionProtocol
    
    public init(with session: URLSessionProtocol) {
        self.session = session
    }
    
    public func reqeust<Model: Decodable>(
        with endpoint: EndpointType, 
        for type: Model.Type
    ) async throws -> Model {
        let urlRequest: URLRequest = try makeURLRequset(with: endpoint)
        let (data, response) = try await request(with: urlRequest)
        try validateReponse(response)
        let model = try decodeModel(from: data, modelType: Model.self)
        return model
    }
    
    private func makeURLRequset(with endpoint: EndpointType) throws -> URLRequest {
        do {
            return try endpoint.asURLRequest()    
        } catch {
            throw NetworkError.invalidUrlRequest
        }
    }
    
    private func request(with urlRequest: URLRequest) async throws -> (Data, URLResponse) {
        do {
            return try await session.data(for: urlRequest, delegate: nil)
        } catch {
            throw NetworkError.dataTaskFailed
        }
    }
    
    private func validateReponse(_ response: URLResponse) throws {
        let correctStatusCodeRange: Range<Int> = 200..<300
        guard 
            let response = response as? HTTPURLResponse,
            correctStatusCodeRange ~= response.statusCode 
        else {
            throw NetworkError.invalidStatus
        }
    }
    
    private func decodeModel<Model: Decodable>(
        from data: Data, 
        modelType: Model.Type
    ) throws -> Model {
        guard let model = try? JSONDecoder().decode(Model.self, from: data) else {
            throw NetworkError.unableToDecode
        }
        return model
    }
}
