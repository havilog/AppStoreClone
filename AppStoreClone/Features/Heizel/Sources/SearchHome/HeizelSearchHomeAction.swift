//
//  SearchHomeAction.swift
//  Heizel
//
//  Created by Dozzing on 2022/04/22.
//  Copyright © 2022 havi. All rights reserved.
//

import Foundation
import ThirdPartyManager
import ComposableArchitecture
import Core

public enum HeizelSearchHomeAction {
    case searchButtonTapped(term: String)
    case searchResultResponse(Result<SearchResult, Error>)
}
