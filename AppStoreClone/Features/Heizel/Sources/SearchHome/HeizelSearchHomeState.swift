//
//  HeizelSearchHomeState.swift
//  Heizel
//
//  Created by Dozzing on 2022/04/22.
//  Copyright © 2022 havi. All rights reserved.
//

import Foundation

public struct HeizelSearchHomeState: Equatable {
    var searchResult: SearchResult?
    var error: Error?

    public init() { }

    public static func == (lhs: HeizelSearchHomeState, rhs: HeizelSearchHomeState) -> Bool {
        return lhs.searchResult == rhs.searchResult
    }
}
