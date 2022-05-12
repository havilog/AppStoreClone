//
//  SearchResultCore.swift
//  Chos
//
//  Created by 조상호 on 2022/05/05.
//  Copyright © 2022 havi. All rights reserved.
//

import Foundation
import ComposableArchitecture
import Combine

public struct SearchResultState: Equatable {
  let appInfo: SearchDomain.AppData = .defaultValue()
  var isExtendedNewFeature: Bool = false
  var isExtendedAppInfo: Bool = false

  public init() {}
}

public enum SearchResultAction: Equatable {
  case onTapShare
  case onTapVersionHistory
  case onTapExtendNewFeature
  case onTapExtendAppInfo
  case onTapShowAllReview
  case onTapReview
}

public struct SearchResultEnvironment {
  let receiveQueue: DispatchQueue

  public init(receiveQueue: DispatchQueue) {
    self.receiveQueue = receiveQueue
  }
}

public let searchResultReducer = Reducer<SearchResultState, SearchResultAction, SearchResultEnvironment> {
  state, action, environment in
  switch action {
  case .onTapShare:
    return .none

  case .onTapVersionHistory:
    return .none

  case .onTapExtendNewFeature:
    return .none

  case .onTapExtendAppInfo:
    return .none

  case .onTapShowAllReview:
    return .none

  case .onTapReview:
    return .none
  }
}
