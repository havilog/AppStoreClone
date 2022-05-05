//
//  HeizelSearchHomeEnvironment.swift
//  Heizel
//
//  Created by Dozzing on 2022/04/22.
//  Copyright © 2022 havi. All rights reserved.
//

import Foundation
import ThirdPartyManager
import ComposableArchitecture
import Core

public struct HeizelSearchHomeEnvironment {
    public let network: NetworkRepository

    public init(network: NetworkRepository = NetworkRepositoryImpl(with: URLSession(configuration: .ephemeral))) {
        self.network = network
    }

    public func search(_ term: String) -> Effect<SearchResult, Error> {
        return URLSession.shared
            .dataTaskPublisher(for: try! Endpoint.searchApp(term: term).asURLRequest())
            .mapError { _ in NetworkError.dataTaskFailed }
            .map { data, _ in data }
            .decode(type: SearchResult.self, decoder: JSONDecoder())
            .mapError { error in
                print(error)
                return NetworkError.unableToDecode
            }
            .eraseToEffect()
    }
}
