//
//  MainTabReducer.swift
//  AppStoreClone
//
//  Created by 한상진 on 2022/04/01.
//  Copyright © 2022 havi. All rights reserved.
//

import ThirdPartyManager
import ComposableArchitecture

import Havi
import Core

let MainTabReducer = Reducer<
    MainTabState, 
        MainTabAction, 
        SystemEnvironment<MainTabEnvironment>
>.combine(
    haviSearchHomeReducer.pullback(
        state: \.haviSearchState, 
        action: /MainTabAction.haviAction, 
        environment: { _ in
            let session = URLSession(configuration: .default)
            let network = NetworkRepositoryImpl(with: session)
            return HaviSearchHomeEnvironment(network: network) 
        }
    )
    // 
    //
)
//    .debug()
