//
//  Network.swift
//  Heizel
//
//  Created by Dozzing on 2022/04/10.
//  Copyright © 2022 havi. All rights reserved.
//

import Foundation
import Combine

class Network {

    enum Methods: String {
        case GET = "GET"
        case POST = "POST"
    }

    enum Errors: LocalizedError {
        case badRequest
        case badServerResponse
        case serverError
        case unhandled
    }

    static let shared = Network()

    var decoder: JSONDecoder

    private init() {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .millisecondsSince1970
        self.decoder = jsonDecoder
    }

    func request(urlString: String,
                 method: Network.Methods = .GET,
                 headers: [String: String]? = nil,
                 parameters: [String: Any]? = nil
    ) -> AnyPublisher<Data, Error> {
        guard let urlReqest = makeURLRequest(urlString: urlString, method: method, headers: headers, parameters: parameters) else {
            return Fail(error: Errors.badRequest).eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: urlReqest)
            .tryMap { [weak self] (data, response) -> Data in
                try self?.handleError(maybeData: data, maybeHttpResponse: response)
                return data
            }
            .eraseToAnyPublisher()
    }

    func request<ResponseData: Decodable>(urlString: String,
                                          method: Network.Methods = .GET,
                                          headers: [String: String]? = nil,
                                          parameters: [String: Any]? = nil
    ) -> AnyPublisher<ResponseData, Error> {
        return request(urlString: urlString, method: method, headers: headers, parameters: parameters)
            .decode(type: ResponseData.self, decoder: decoder)
            .eraseToAnyPublisher()
    }

    private func makeURLRequest(urlString: String,
                                method: Network.Methods = .GET,
                                headers: [String: String]? = nil,
                                parameters: [String: Any]? = nil
    ) -> URLRequest? {
        guard var url = URL(string: urlString),
              var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            return nil
        }

        var urlRequest: URLRequest

        if let parameters = parameters {
            components.queryItems = parameters.map { (name, value) -> URLQueryItem in
                return URLQueryItem(name: name, value: "\(value)")
            }
            url = components.url ?? url
        }
        urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue

        if let headers = headers {
            headers.forEach { (key, value) in
                urlRequest.addValue(value, forHTTPHeaderField: key)
            }
        }

        return urlRequest
    }

    private func handleError(maybeData: Data, maybeHttpResponse: URLResponse) throws {
        guard let httpResponse = maybeHttpResponse as? HTTPURLResponse else {
            throw Errors.badServerResponse
        }

        let statusCode = httpResponse.statusCode
        if 200..<300 ~= statusCode { return }
        else if 400..<500 ~= statusCode { throw Errors.badRequest }
        else if statusCode >= 500 { throw Errors.serverError }
    }

}

