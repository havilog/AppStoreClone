//
//  SearchResult.swift
//  Heizel
//
//  Created by Dozzing on 2022/04/10.
//  Copyright © 2022 havi. All rights reserved.
//

import Foundation

public struct SearchResult: Decodable, Equatable {
    let resultCount: Int
    let results: [SearchItemResult]

    static func == (lhs: SearchResult, rhs: SearchResult) -> Bool {
        return lhs.resultCount == rhs.resultCount &&
        lhs.results == rhs.results
    }
}

public struct SearchItemResult: Decodable, Equatable {
    let wrapperType: String
    let kind: String
    let artistId: Int
    let collectionId: Int
    let artistName: String
    let collectionName: String
    let trackName: String
    let collectionCensoredName: String
    let trackCensoredName: String
    let artistViewUrl: String
    let collectionViewUrl: String
    let trackViewUrl: String
    let previewUrl: String?
    let artworkUrl60: String?
    let artworkUrl100: String?
    let collectionPrice: Double
    let trackPrice: Double
    let currency: String
    let trackID: Int
}
