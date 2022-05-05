//
//  HeizelSearchHomeReducer.swift
//  Heizel
//
//  Created by Dozzing on 2022/04/22.
//  Copyright © 2022 havi. All rights reserved.
//

import Foundation
import ThirdPartyManager
import ComposableArchitecture

let heizelSearchHomeReducer = Reducer<HeizelSearchHomeState, HeizelSearchHomeAction, HeizelSearchHomeEnvironment> { state, action, environment in
    switch action {
    case .searchButtonTapped(let term):
        return environment.search(term)
            .receive(on: environment.mainQueue)
            .catchToEffect()
            .map(HeizelSearchHomeAction.searchResultResponse)
    case .searchResultResponse(.success(let result)):
        state.searchResult = result
        return .none
    case .searchResultResponse(.failure(let error)):
        state.error = error
        return .none
    }
}
