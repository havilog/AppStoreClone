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

    public static func == (lhs: SearchResult, rhs: SearchResult) -> Bool {
        return lhs.resultCount == rhs.resultCount &&
        lhs.results == rhs.results
    }
}

public struct SearchItemResult: Decodable, Equatable {
//    public let wrapperType: String
//    public let kind: String
//    public let artistId: Int
//    public let collectionId: Int
//    public let artistName: String
//    public let collectionName: String
    public let trackName: String
    public let description: String
    public let version: String
    public let releaseNotes: String?
    public let averageUserRating: Float?
//    public let collectionCensoredName: String
//    public let trackCensoredName: String
//    public let artistViewUrl: String
//    public let collectionViewUrl: String
//    public let trackViewUrl: String
//    public let previewUrl: String?
    public let artworkUrl60: URL
    public let artworkUrl100: URL
    public let artworkUrl512: URL
    public let screenshotUrls: [URL]
//    public let trackPrice: Double
//    public let currency: String
//    public let trackID: Int

    public static var kakao: SearchItemResult {
        let trackName = "카카오"
        let url160 =  URL(string: "https://is5-ssl.mzstatic.com/image/thumb/Purple115/v4/c5/6c/d0/c56cd0dd-6363-13be-0eff-26b937f5ffb5/AppIcon-0-0-1x_U007emarketing-0-0-0-5-0-0-sRGB-0-0-0-GLES2_U002c0-512MB-85-220-0-0.png/60x60bb.jpg"
        )!
        let url100 =  URL(string: "https://is5-ssl.mzstatic.com/image/thumb/Purple115/v4/c5/6c/d0/c56cd0dd-6363-13be-0eff-26b937f5ffb5/AppIcon-0-0-1x_U007emarketing-0-0-0-5-0-0-sRGB-0-0-0-GLES2_U002c0-512MB-85-220-0-0.png/100x100bb.jpg"
        )!
        let url512 = URL(string: "https://is5-ssl.mzstatic.com/image/thumb/Purple115/v4/c5/6c/d0/c56cd0dd-6363-13be-0eff-26b937f5ffb5/AppIcon-0-0-1x_U007emarketing-0-0-0-5-0-0-sRGB-0-0-0-GLES2_U002c0-512MB-85-220-0-0.png/512x512bb.jpg")!
        let screentshots: [URL] = [
            URL(string: "https://is1-ssl.mzstatic.com/image/thumb/PurpleSource126/v4/cd/f5/45/cdf5450b-70c3-c4ff-62f7-459e96b3bd0c/645b5f7a-5ff9-43a0-aefa-e4a5e80468c0_5.5_screenshot_01.png/392x696bb.png")!,
            URL(string: "https://is3-ssl.mzstatic.com/image/thumb/PurpleSource116/v4/ae/39/2c/ae392c8a-b8ab-ffb9-0775-1c5ae5046c76/2354ae48-4269-40d0-b388-c362715cc973_5.5_screenshot_02.png/392x696bb.png")!,
            URL(string: "https://is4-ssl.mzstatic.com/image/thumb/PurpleSource126/v4/74/c0/64/74c064e9-80a0-7b3b-a411-bdd0ec7e0e0c/f7b60d70-a895-4ae4-a3aa-7cdfc0f0ed5d_5.5_screenshot_03.png/392x696bb.png")!,
            URL(string: "https://is5-ssl.mzstatic.com/image/thumb/PurpleSource126/v4/c9/24/e3/c924e3c8-7fe6-5a7c-85be-6489940d0d15/d9d3bdda-1cbc-4433-9e41-aeafb482bec1_5.5_screenshot_04.png/392x696bb.png")!,
            URL(string: "https://is4-ssl.mzstatic.com/image/thumb/PurpleSource126/v4/e4/d0/f3/e4d0f340-9719-60b9-c2ff-16204c815318/56ec8853-3ab7-467d-a4a6-91543f0f3a12_5.5_screenshot_05.png/392x696bb.png")!,
            URL(string: "https://is5-ssl.mzstatic.com/image/thumb/PurpleSource126/v4/e5/dc/6a/e5dc6a20-a0f9-d275-3d1e-0e4679dc11b9/70cd8c73-8106-473f-a577-5c38a91dde9c_5.5_screenshot_06.png/392x696bb.png")!,
            URL(string: "https://is3-ssl.mzstatic.com/image/thumb/PurpleSource116/v4/50/c6/14/50c6143f-de61-d1ea-3ebb-ea0410ade3a4/247996e7-e734-4fb7-9ebb-ef6e23401025_5.5_screenshot_07.png/392x696bb.png")!,
            URL(string: "https://is5-ssl.mzstatic.com/image/thumb/PurpleSource116/v4/7f/8f/d6/7f8fd643-f60d-d7cb-585e-4dfdb53fbf0d/f090e40b-b0a5-457d-ad04-511ba9b3730f_5.5_screenshot_08.png/392x696bb.png")!
        ]
        return .init(
            trackName: trackName,
            description: "모든 연결의 시작, 카카오톡",
            version: "9.7.9",
            releaseNotes: "버전 노트",
            averageUserRating: 5.0,
            artworkUrl60: url160,
            artworkUrl100: url100,
            artworkUrl512: url512,
            screenshotUrls: screentshots
        )
    }

    public static var empty: SearchItemResult {
        let trackName = ""
        let url160 = URL(string: "")!
        let url100 = URL(string: "")!
        let url512 = URL(string: "")!
        return .init(
            trackName: trackName,
            description: "",
            version: "",
            releaseNotes: nil,
            averageUserRating: 0.0,
            artworkUrl60: url160,
            artworkUrl100: url100,
            artworkUrl512: url512,
            screenshotUrls: []
        )
    }
}
