//
//  HaviSearchResultReducer.swift
//  Havi
//
//  Created by 한상진 on 2022/03/29.
//  Copyright © 2022 havi. All rights reserved.
//

import ThirdPartyManager
import ComposableArchitecture

let HaviSearchResultReducer = Reducer<HaviSearchResultState, HaviSearchResultAction, HaviSearchResultEnvironment>.combine(
    Reducer { state, action, environment in
        switch action {
        }
    }
)
    .debug()
