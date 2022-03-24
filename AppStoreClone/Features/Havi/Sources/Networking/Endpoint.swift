//
//  Endpoint.swift
//  Core
//
//  Created by 한상진 on 2022/03/25.
//  Copyright © 2022 havi. All rights reserved.
//

import Foundation

// MARK: Constant

public typealias HTTPHeaders = [String: String]
public typealias Parameters = [String: Any?]

public enum HTTPHeaderFields {
    static let contentType: String = "Content-Type"
    static let json: String = "application/json"
}

public enum HTTPMethod: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case patch = "PATCH"
    case delete = "DELETE"
}

public enum HTTPTask {
    case requestPlain
    case requestHeader(urlParams: Parameters?)
    case requestBody(body: Any?)
}

public enum NetworkError: Error {
    case invalidUrlRequest
    
    case dataTaskFailed
    case invalidStatus
    case unableToDecode
    
    case encodeHeaderFail
    case encodeBodyFail 
}

// MARK: Protocol

public protocol EndpointType {
    var baseURL: URL { get }
    var path: String? { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
    func asURLRequest() throws -> URLRequest
}

// MARK: Endpoint

public enum Endpoint {
    case readCarrots
}

extension Endpoint: EndpointType {
    public var baseURL: URL {
        guard let baseURL = URL(string: "http://carrot.mock.com") 
        else { fatalError("잘못된 baseURL") }
        
        return baseURL
    }
    
    public var path: String? {
        switch self {
        case .readCarrots:
            return "/some/path/"
        }
    }
    
    public var httpMethod: HTTPMethod {
        switch self {
        case .readCarrots:
            return .get
        }
    }
    
    public var task: HTTPTask {
        switch self {
        case .readCarrots:
            return .requestPlain
        }
    }
    
    public var headers: HTTPHeaders? {
        return [
            HTTPHeaderFields.contentType: HTTPHeaderFields.json
        ]
    }
    
    // MARK: URLRequest
    
    public func asURLRequest() throws -> URLRequest {
        var url: URL = baseURL
        
        url.appendPathComponent(path ?? "")
        
        var request: URLRequest = .init(url: url)
        
        request.httpMethod = httpMethod.rawValue
        request.allHTTPHeaderFields = headers
        
        switch task {
        case .requestPlain:
            break
            
        case let .requestHeader(parameters):
            try encodeHeader(&request, with: parameters)
            
        case let .requestBody(parameters):
            try encodeBody(&request, with: parameters)
        }
        
        return request
    }
    
    // MARK: Encoder
    
    private func encodeHeader(_ request: inout URLRequest, with parameter: Parameters?) throws {
        guard let parameter = parameter, 
              let url = request.url,
              var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false),
              !parameter.isEmpty   
        else { throw NetworkError.encodeHeaderFail }
        
        urlComponents.queryItems = parameter
            .compactMapValues { $0 }
            .compactMap { URLQueryItem(name: $0.key, value: "\($0.value)") }
        
        request.url = urlComponents.url
    }
    
    private func encodeBody(_ request: inout URLRequest, with parameter: Any?) throws {
        guard let parameter = parameter,
              let encodableParameter = parameter as? Encodable,
              let json = encodableParameter.toJSON(),
              let data = try? JSONSerialization.data(withJSONObject: json, options: [])      
        else { throw NetworkError.encodeBodyFail }
        
        request.httpBody = data
    }
}

extension Encodable {
    fileprivate func toJSON(_ encoder: JSONEncoder = JSONEncoder()) -> [String: Any]? {
        encoder.keyEncodingStrategy = .convertToSnakeCase
        
        guard let data = try? encoder.encode(self),
              let object = try? JSONSerialization.jsonObject(with: data),      
              let json = object as? [String: Any] 
        else { return nil }
        
        return json
    }
}
