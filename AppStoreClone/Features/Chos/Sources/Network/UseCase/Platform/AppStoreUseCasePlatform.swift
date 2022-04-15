//
//  AppStoreUseCasePlatform.swift
//  Chos
//
//  Created by 조상호 on 2022/04/05.
//  Copyright © 2022 havi. All rights reserved.
//

import Foundation
import ComposableArchitecture
import Alamofire
import Combine

public struct AppStoreUseCasePlatform {
  public init(apiNetworking: APINetworking & CombineAPINetworkRequestType) {
    self.apiNetworking = apiNetworking
  }
  
  let apiNetworking: APINetworking & CombineAPINetworkRequestType

  private var baseURL: String {
    apiNetworking.domainURL
  }
}

extension AppStoreUseCasePlatform: AppStoreUseCase {
  public var searchKeyword: (SearchDomain.Request.SearchRequest) -> Effect<SearchDomain.SearchResult, CompositingErrorDomain> {
    { requestModel in
      
      let model = APIRequestModel(
        baseURL: baseURL,
        parameters: ParameterConverter.build(model: requestModel),
        method: .get)
      
      return apiNetworking
        .request(model: model)
        .decode(type: SearchDomain.SearchResult.self, decoder: JSONDecoder())
        .mapError{ error in
          guard let err = error as? CompositingErrorDomain else { return .other(error) }
          return err
        }
        .eraseToAnyPublisher()
        .eraseToEffect()
    }
  }
}

