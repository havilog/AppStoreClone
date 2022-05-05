//
//  HaviSearchFeature.swift
//  Havi
//
//  Created by 한상진 on 2022/04/17.
//  Copyright © 2022 havi. All rights reserved.
//

import Core
import Combine
import Foundation
import ThirdPartyManager
import ComposableArchitecture

public struct HaviSearchHomeEnvironment {
    var searchClient: SearchClient
    
    public init(searchClient: SearchClient) {
        self.searchClient = searchClient
    }
}

public enum HaviSearchHomeAction: Equatable {
    case searchKeywordChanged(String)
    case searchButtonTapped
    case searchDataLoaded(Result<SearchAPIResult, SearchClient.SearchFailure>)
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
            return environment.searchClient
                .searchQuery(state.query)
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
