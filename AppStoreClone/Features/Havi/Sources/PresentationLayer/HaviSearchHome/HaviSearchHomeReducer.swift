//
//  HaviSearchHomeReducer.swift
//  Havi
//
//  Created by 한상진 on 2022/03/29.
//  Copyright © 2022 havi. All rights reserved.
//

import Foundation

import ThirdPartyManager
import ComposableArchitecture

public let haviSearchHomeReducer = Reducer<
    HaviSearchHomeState, 
        HaviSearchHomeAction, 
        HaviSearchHomeEnvironment
>.combine(
    Reducer { state, action, environment in
        switch action {
        case let .searchButtonTapped(term):
            return environment.searchRequest(term: term, decoder: .init())
                .receive(on: DispatchQueue.main)
                .catchToEffect()
                .map(HaviSearchHomeAction.searchDataLoaded)
            
        case let .searchDataLoaded(result):
            switch result {
            case let .success(searchResult):
                print("success")
                state.searchModel = searchResult
                
            case let .failure(error):
                print(error)
            }
            return .none
            
//        case let .searchKeywordChanged(keyword):
//            return .none
        }
    }
)
//    .debug()
