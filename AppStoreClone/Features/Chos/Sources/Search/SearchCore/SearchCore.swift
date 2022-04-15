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

public struct ChosSearchState: Equatable {
  var searchKeyword: String = ""
  var recentlyKeyword: [String] = []
  var searchResults: [SearchDomain.AppData] = []

  public init() {}
}

public enum ChosSearchAction: Equatable {
  case onSearchKeyword(String)
  case onRecieveValue(Result<SearchDomain.SearchResult, CompositingErrorDomain>)
  case onTapResult(SearchDomain.SearchResult)
}

public struct ChosSearchEnvironment {
  let environment: SearchEnvironment
  let receiveQueue: DispatchQueue

  public init(environment: SearchEnvironment, receiveQueue: DispatchQueue) {
    self.environment = environment
    self.receiveQueue = receiveQueue
  }
}

public let chosSearchReducer = Reducer<ChosSearchState, ChosSearchAction, ChosSearchEnvironment> {
  state, action, environment in
  switch action {
  case let .onSearchKeyword(keyword):
    struct SearchKeywordId: Hashable {}

    return environment.environment.appStoreUsecase
      .searchKeyword(.init(term: keyword, entity: "", country: "", lang: ""))
      .catchToEffect(ChosSearchAction.onRecieveValue)
      .cancellable(id: SearchKeywordId(), cancelInFlight: true)

  case .onTapResult:
    return .none

  case let .onRecieveValue(.failure(error)):
    return .none

  case let.onRecieveValue(.success(result)):
    state.searchResults = result.results
    return .none
  }
}
