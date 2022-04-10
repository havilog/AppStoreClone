//
//  HaviSearchHomeAction.swift
//  Havi
//
//  Created by 한상진 on 2022/03/29.
//  Copyright © 2022 havi. All rights reserved.
//

import Core
import ThirdPartyManager
import ComposableArchitecture

import Core

public enum HaviSearchHomeAction: Equatable {
    case searchButtonTapped(keyword: String)
    case searchDataLoaded(Result<SearchAPIResult, NetworkError>)
}
