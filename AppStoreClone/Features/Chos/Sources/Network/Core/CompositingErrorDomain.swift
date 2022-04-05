//
//  CompositingError.swift
//  Chos
//
//  Created by 조상호 on 2022/03/29.
//  Copyright © 2022 havi. All rights reserved.
//

import Foundation

public enum CompositingErrorDomain: Error {
  case networkNotFound
  case notFoundData
  case networkUnknown
  case networkRemoteFail(RemoteErrorDomain)
  case other(Error)
  
  public var displayMessage: String {

    switch self {
    case .networkNotFound:
      return "Network is offline. please reconnect the Network."
    case let .networkRemoteFail(domain):
      return domain.message ?? ""
    default:
      return otherMessage
    }
  }

  private var otherMessage: String {
    "Missing Error"
  }
}

public struct RemoteErrorDomain: Decodable {
  public init(code: Int?, message: String?) {
    self.code = code
    self.message = message
  }

  public var code: Int?
  public var message: String?

  private enum CodingKeys: String, CodingKey {
    case code, message
  }
}
