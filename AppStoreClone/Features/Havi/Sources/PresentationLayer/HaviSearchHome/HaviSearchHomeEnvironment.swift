//
//  HaviSearchHomeEnvironment.swift
//  Havi
//
//  Created by 한상진 on 2022/03/29.
//  Copyright © 2022 havi. All rights reserved.
//

import Foundation
import Combine

import Core
import ThirdPartyManager
import ComposableArchitecture

public struct HaviSearchHomeEnvironment {
    
    public let network: NetworkRepository
    
    public init(network: NetworkRepository) {
        self.network = network
    }
    
    public func searchRequest(
        term: String,
        decoder: JSONDecoder
    ) -> Effect<SearchAPIResult, NetworkError> {
        return URLSession.shared
            .dataTaskPublisher(for: try! Endpoint.searchApp(term: term).asURLRequest())
            .mapError { _ in NetworkError.dataTaskFailed }
            .map { data, _ in data }
            .decode(type: SearchAPIResult.self, decoder: decoder)
            .mapError { _ in NetworkError.unableToDecode }
            .eraseToEffect()
    }
}
