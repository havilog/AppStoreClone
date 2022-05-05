//
//  MainTabAction.swift
//  AppStoreClone
//
//  Created by 한상진 on 2022/04/01.
//  Copyright © 2022 havi. All rights reserved.
//

import ThirdPartyManager
import ComposableArchitecture

import Havi
import Heizel

enum MainTabAction: Equatable {
    static func == (lhs: MainTabAction, rhs: MainTabAction) -> Bool {
        return lhs.self == rhs.self
    }

    case haviAction(HaviSearchHomeAction)
    // chosAction
    case heizelAction(HeizelSearchHomeAction)

}
