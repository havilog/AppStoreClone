//
//  SearchCore.swift
//  Chos
//
//  Created by 조상호 on 2022/03/29.
//  Copyright © 2022 havi. All rights reserved.
//

import Foundation
import ComposableArchitecture
import Combine

struct SearchState: Equatable {
  var searchKeyword: String = ""
  var recentlyKeyword: [String] = []
  var searchResults: [String]
}

enum SearchAction: Equatable {
  case onSearchKeyword(String)
  case onTapResult
}

struct SearchEnvironment {
  var environment: SearchEnvironmentType
  var receiveQueue: DispatchQueue {
    DispatchQueue.main
  }
}

let searchReducer = Reducer<SearchState, SearchAction, SearchEnvironment> {
  state, action, environment in
  switch action {
  case let .onSearchKeyword(keyword):
    return .init(value: .onTapResult)
    break

  case .onTapResult:
    return .init(value: .onTapResult)
    break
  }
}
