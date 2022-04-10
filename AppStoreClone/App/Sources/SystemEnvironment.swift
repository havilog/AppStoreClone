//
//  SystemEnvironment.swift
//  AppStoreClone
//
//  Created by 한상진 on 2022/04/10.
//  Copyright © 2022 havi. All rights reserved.
//

import ComposableArchitecture

@dynamicMemberLookup
struct SystemEnvironment<Environment> {
  var environment: Environment

  subscript<Dependency>(
    dynamicMember keyPath: WritableKeyPath<Environment, Dependency>
  ) -> Dependency {
    get { self.environment[keyPath: keyPath] }
    set { self.environment[keyPath: keyPath] = newValue }
  }

  var mainQueue: () -> AnySchedulerOf<DispatchQueue>
  var decoder: () -> JSONDecoder

  private static func decoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    return decoder
  }

  static func live(environment: Environment) -> Self {
    Self(environment: environment, mainQueue: { .main }, decoder: decoder)
  }

  static func dev(environment: Environment) -> Self {
    Self(environment: environment, mainQueue: { .main }, decoder: decoder)
  }
}
