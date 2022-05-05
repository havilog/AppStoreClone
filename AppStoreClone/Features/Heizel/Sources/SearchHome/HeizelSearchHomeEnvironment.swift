//
//  HeizelSearchHomeEnvironment.swift
//  Heizel
//
//  Created by Dozzing on 2022/04/22.
//  Copyright © 2022 havi. All rights reserved.
//

import Foundation
import ThirdPartyManager
import ComposableArchitecture

public struct HeizelSearchHomeEnvironment {
    var mainQueue: AnySchedulerOf<DispatchQueue>
    var search: (String) -> Effect<SearchResult, Error>
}
