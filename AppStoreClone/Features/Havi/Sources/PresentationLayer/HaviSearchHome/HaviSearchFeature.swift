//
//  HaviSearchFeature.swift
//  Havi
//
//  Created by 한상진 on 2022/04/17.
//  Copyright © 2022 havi. All rights reserved.
//

import SwiftUI
import Combine
import Foundation

import Core
import ThirdPartyManager
import ComposableArchitecture

public struct HaviSearchHomeEnvironment {
    
    public let network: NetworkRepository
    
    public init(
        network: NetworkRepository = NetworkRepositoryImpl(with: URLSession(configuration: .ephemeral))
    ) {
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
//        return ComposableArchitecture.Effect.task {
//            let result = try await network.reqeust(
//                with: Endpoint.searchApp(term: term), 
//                for: SearchAPIResult.self
//            )
//            return result
//        }
    }
    
//    public func searchRelatedKeyword(
//        term: String,
//        decoder: JSONDecoder
//    ) -> Effect<SearchAPIResult, NetworkError> {
//        
//    }
}

public enum HaviSearchHomeAction: Equatable {
    case searchKeywordChanged(query: String)
    case searchButtonTapped
    case searchDataLoaded(Result<SearchAPIResult, NetworkError>)
}

public struct HaviSearchHomeState: Equatable {
    var searchModel: SearchAPIResult?
    var query: String = ""
    
    public init() { }
}

public let haviSearchHomeReducer = Reducer<HaviSearchHomeState, HaviSearchHomeAction, HaviSearchHomeEnvironment>.combine(
    Reducer { state, action, environment in
        switch action {
        case .searchButtonTapped:
            return environment.searchRequest(term: state.query, decoder: .init())
                .receive(on: DispatchQueue.main)
                .catchToEffect()
                .map(HaviSearchHomeAction.searchDataLoaded)
            
        case let .searchDataLoaded(result):
            switch result {
            case let .success(searchResult):
                state.searchModel = searchResult
                
            case let .failure(error):
                print(error)
            }
            return .none
            
        case let .searchKeywordChanged(query):
            state.query = query
            return .none
        }
    }
)
