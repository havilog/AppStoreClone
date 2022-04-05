//
//  RequestType.swift
//  Chos
//
//  Created by 조상호 on 2022/03/29.
//  Copyright © 2022 havi. All rights reserved.
//

import Foundation
import Alamofire
import Combine

enum RequestModelExtraType {
  enum Method {
    case get, delete, post, put
  }
  
  enum Encoding {
    case `default`, json
  }
}

public protocol APINetworking {
  var domainURL: String { get }
}

protocol RequestModelType {
  var baseURL: String { get }
  var pathURL: String { get }
  var headers: [String: Any] { get }
  var parameters: [String: Any] { get }
  var method: RequestModelExtraType.Method { get }
  var encoding: RequestModelExtraType.Encoding { get }
}

public protocol AlamofireRequestModelConvertable {
  var AFHeaders: Alamofire.HTTPHeaders? { get }
  var AFMethod: Alamofire.HTTPMethod { get }
  var AFEncoding: Alamofire.ParameterEncoding { get }
}

extension AlamofireRequestModelConvertable where Self: RequestModelType {
  var AFHeaders: Alamofire.HTTPHeaders? {
    let headerList = headers
      .map{ ($0.key, "\($0.value)") }
      .map(Alamofire.HTTPHeader.init(name: value:))
    
    return Alamofire.HTTPHeaders(headerList)
  }
  var AFMethod: Alamofire.HTTPMethod {
    switch method {
    case .get: return Alamofire.HTTPMethod.get
    case .delete: return Alamofire.HTTPMethod.delete
    case .post: return Alamofire.HTTPMethod.post
    case .put: return Alamofire.HTTPMethod.put
    }
  }
  
  var AFEncoding: Alamofire.ParameterEncoding {
    switch encoding {
    case .default: return URLEncoding.default
    case .json: return JSONEncoding(options: .fragmentsAllowed)
    }
  }
}

public protocol DefaultParameterValue {
  func makeCompositedURLPath(domainURL: String) -> String
  func makeCompositedRequestParameter() -> [String: Any]
}

extension DefaultParameterValue where Self: RequestModelType {
  func makeCompositedURLPath(domainURL: String) -> String {
    let url = baseURL.isEmpty ? domainURL : baseURL
    return url + "/search"
  }
  
  func makeCompositedRequestParameter() -> [String: Any] {
    parameters
  }
}

public protocol CombineAPINetworkRequestType {
  func request(model: AlamofireRequestModelConvertable & DefaultParameterValue) -> AnyPublisher<Data, CompositingErrorDomain>
}
