//
//  APIRequestModel.swift
//  Chos
//
//  Created by 조상호 on 2022/04/05.
//  Copyright © 2022 havi. All rights reserved.
//

import Foundation

struct APIRequestModel: RequestModelType {
  let baseURL: String
  let pathURL: String
  let headers: [String : Any]
  let parameters: [String : Any]
  let method: RequestModelExtraType.Method
  let encoding: RequestModelExtraType.Encoding
  
  public init(
    baseURL: String = "",
    pathURL: String = "",
    headers: [String: Any] = [:],
    parameters: [String: Any] = [:],
    method: RequestModelExtraType.Method,
    encoding: RequestModelExtraType.Encoding = .default)
  {
    self.baseURL = baseURL
    self.pathURL = pathURL
    self.headers = headers
    self.parameters = parameters
    self.method = method
    self.encoding = encoding
  }
}

extension APIRequestModel: AlamofireRequestModelConvertable, DefaultParameterValue {
  
}
