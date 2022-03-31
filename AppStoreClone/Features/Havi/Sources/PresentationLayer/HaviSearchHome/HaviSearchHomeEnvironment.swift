//
//  HaviSearchHomeEnvironment.swift
//  Havi
//
//  Created by 한상진 on 2022/03/29.
//  Copyright © 2022 havi. All rights reserved.
//

import Core
import ThirdPartyManager
import ComposableArchitecture

struct HaviSearchHomeEnvironment {
    let network: NetworkRepository
    
    init(network: NetworkRepository) {
        self.network = network
    }
}
