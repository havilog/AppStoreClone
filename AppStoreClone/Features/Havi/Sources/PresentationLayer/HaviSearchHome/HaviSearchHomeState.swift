//
//  HaviSearchHomeState.swift
//  Havi
//
//  Created by 한상진 on 2022/03/29.
//  Copyright © 2022 havi. All rights reserved.
//

import SwiftUI

import ThirdPartyManager
import ComposableArchitecture

public struct HaviSearchHomeState: Equatable {
    var searchModel: SearchAPIResult?
    
    public init() { }
}
