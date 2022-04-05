//
//  ParameterConverter.swift
//  Chos
//
//  Created by 조상호 on 2022/04/05.
//  Copyright © 2022 havi. All rights reserved.
//

import Foundation

public struct ParameterConverter {
  static func build(model: Encodable) -> [String: Any] {
    guard let data = try? model.toEncodedData(),
          let dic = try? JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? [String: Any]
    else { return [:] }
    
    return dic
  }
}


extension Encodable {
  func toEncodedData() throws -> Data {
    try JSONEncoder().encode(self)
  }
}
