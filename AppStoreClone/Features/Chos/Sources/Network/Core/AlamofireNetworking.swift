//
//  AlamofireNetworking.swift
//  Chos
//
//  Created by 조상호 on 2022/03/29.
//  Copyright © 2022 havi. All rights reserved.
//

import Foundation
import Alamofire
import Combine
import ThirdPartyManager
import Moya

class SessionManager {
  private init() {}
  
  static let shared = SessionManager()

  fileprivate let session: Session = {
    let session = Session()
    
    session.sessionConfiguration.httpCookieAcceptPolicy = .always
    
    return session
  }()
}

public struct AlamofireAPINetworking: APINetworking {
  public let domainURL: String
  
  public init(domainURL: String) {
    self.domainURL = domainURL
  }
}

private struct AlamofireAPIProducer {
  static var responseProducer: (Int?, Data?, AFError?) -> Result<Data,CompositingErrorDomain> {
    { statusCode, data, _ in
      guard let statusCode = statusCode else {
        return .failure(.networkNotFound)
      }
      
      guard let data = data else { return .failure(.notFoundData) }
      
      switch statusCode {
        case 401:
          return .failure(CompositingErrorDomain.networkNotFound)
        case 200 ... 299:
          return .success(data)
        default: break
      }
      
      return statusCode == 404
      ? .failure(CompositingErrorDomain.networkNotFound)
      : .failure(CompositingErrorDomain.networkUnknown)
    }
  }
}

extension AlamofireAPINetworking: CombineAPINetworkRequestType {
  public func request(model: AlamofireRequestModelConvertable & DefaultParameterValue) -> AnyPublisher<Data, CompositingErrorDomain> {
    let fullURL = model.makeCompositedURLPath(domainURL: domainURL)
    let parameters = model.makeCompositedRequestParameter()
    
    return Future<Data, CompositingErrorDomain> { promise in
      SessionManager.shared.session.request(
        fullURL,
        method: model.AFMethod,
        parameters: parameters,
        encoding: model.AFEncoding,
        headers: model.AFHeaders)
      .responseData { fetch in
        let logMessage = """
        --------- API Pull --------
        --------- Requeust Info --------
        \(fetch.request?.description ?? "null")
        --------- Requeust Parameter --------
        \(parameters)
        --------- Requeust Body --------
        \(String(data: fetch.request?.httpBody ?? Data(), encoding: .utf8) ?? "null")
        --------- Response --------
        \(fetch.response?.description ?? "null")
        ---------- Response Data --------
        \(String(data: fetch.data ?? Data(), encoding: .utf8) ?? "null")
        ---------- Response Error --------
        \(fetch.error.debugDescription)
        """
        
        print(logMessage)
        
        promise(AlamofireAPIProducer.responseProducer(fetch.response?.statusCode, fetch.value, fetch.error))
      }
    }
    .eraseToAnyPublisher()
  }
}
