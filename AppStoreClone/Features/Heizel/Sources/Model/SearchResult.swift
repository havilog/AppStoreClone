//
//  SearchResult.swift
//  Heizel
//
//  Created by Dozzing on 2022/04/10.
//  Copyright © 2022 havi. All rights reserved.
//

import Foundation

struct SearchResult: Decodable {
    let resultCount: Int
    let results: [SearchItemResult]
}

struct SearchItemResult: Decodable {
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
