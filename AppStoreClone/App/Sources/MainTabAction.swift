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
import Chos

enum MainTabAction: Equatable {
    case haviAction(HaviSearchHomeAction)
    case chosAction(ChosSearchAction)
    // chosAction
    // heizelAction
}
