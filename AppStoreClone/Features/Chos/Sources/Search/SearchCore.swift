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
  var filteredRecentlyKeyword: [String] = []

  public init() {}
}

public enum ChosSearchAction: Equatable {
  case onSearchKeyword(String)
  case onChangedSearchKeyword(String)
  case onRecieveValue(Result<SearchDomain.SearchResult, CompositingErrorDomain>)
  case onTapResult(SearchDomain.AppData)
}

public struct ChosSearchEnvironment {
  let appStoreUsecase: AppStoreUseCase
  let receiveQueue: DispatchQueue

  public init(appStoreUsecase: AppStoreUseCase, receiveQueue: DispatchQueue) {
    self.appStoreUsecase = appStoreUsecase
    self.receiveQueue = receiveQueue
  }
}

public let chosSearchReducer = Reducer<ChosSearchState, ChosSearchAction, ChosSearchEnvironment> {
  state, action, environment in
  switch action {

  case let .onChangedSearchKeyword(keyword):
    ( keyword.isEmpty )
    ? ( state.filteredRecentlyKeyword = [] )
    : ( state.filteredRecentlyKeyword = state.recentlyKeyword.filter{ $0.contains(keyword) } )

    state.searchKeyword = keyword

    return .none

  case let .onSearchKeyword(keyword):
    struct SearchKeywordId: Hashable {}

    state.searchKeyword = keyword

    guard !state.recentlyKeyword.contains(keyword) else { return .none }
    state.recentlyKeyword.append(keyword)

    state.searchResults = []

    return environment.appStoreUsecase
      .searchKeyword(.init(term: state.searchKeyword, entity: "software", country: "KR", lang: "ko_KR"))
      .catchToEffect(ChosSearchAction.onRecieveValue)
      .cancellable(id: SearchKeywordId(), cancelInFlight: true)

  case let .onTapResult(data):

    return .none

  case let .onRecieveValue(.failure(error)):
    return .none

  case let.onRecieveValue(.success(result)):
    state.searchResults = result.results
    return .none
  }
}
