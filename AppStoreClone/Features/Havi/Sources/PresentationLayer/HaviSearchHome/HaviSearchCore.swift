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
    var mainQueue: AnySchedulerOf<DispatchQueue>
    
    public init(
        searchClient: SearchClient,
        mainQueue: AnySchedulerOf<DispatchQueue>
    ) {
        self.searchClient = searchClient
        self.mainQueue = mainQueue
    }
}

public enum HaviSearchHomeAction: Equatable {
    case searchKeywordChanged(String)
    case searchButtonTapped
    case searchDataLoaded(Result<SearchAPIResult, SearchClient.SearchFailure>)
}

public struct HaviSearchHomeState: Equatable {
    struct SearchHistory: Identifiable, Equatable {
        var id: String
    }
    var searchResults: [SearchAPIResult.SearchResult] = []
    var query: String = ""
    var searchHistory: [SearchHistory] = []
    
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
            
        case let .searchDataLoaded(.success(searchResult)):
            state.searchResults = searchResult.results
            
            let history = HaviSearchHomeState.SearchHistory(id: state.query)
            if let existingHistoryIndex = state.searchHistory.firstIndex(of: history) {
                state.searchHistory.remove(at: existingHistoryIndex)
            }
            
            state.searchHistory.append(history)
            return .none
            
        case let .searchDataLoaded(.failure(error)):
            print(error)
            return .none
            
        case let .searchKeywordChanged(query):
            state.query = query
            return .none
        }
    }
)
