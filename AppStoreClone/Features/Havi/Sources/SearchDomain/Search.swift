//
//  Search.swift
//  Havi
//
//  Created by 한상진 on 2022/03/26.
//  Copyright © 2022 havi. All rights reserved.
//

import Foundation

public struct SearchAPIResult: Decodable, Equatable {
    public let resultCount: Int
    public let results: [SearchResult]
}

extension SearchAPIResult {
    public struct SearchResult: Decodable, Equatable {
        public let artworkUrl60: URL // -  60x60사이즈 로고
        public let artworkUrl100: URL // - 100x100사이즈 로고
        public let artworkUrl512: URL // - 512x512사이즈 로고
        public let screenshotUrls: [URL] // - 스크린샷 [Url리스트] - url 디코딩 로직 적용
        public let supportedDevices: [String] // - 지원 기기 목록
        public let minimumOsVersion: String // minimum Deployment Target
        public let trackName: String // 앱 이름
        public let averageUserRating: Double // - 전체 평점
        public let averageUserRatingForCurrentVersion: Double // - 이 버전에 대한평점 0.0~5.0
        public let contentAdvisoryRating: String // - 연령등급
        public let userRatingCount: Int // - 평가 개수 - 1000단위로 반올림 예상, n.n만개 등으로 포매팅 필요
        public let releaseNotes: String // - 릴리즈노트 - 기본 세줄  + 더보기 - 클릭시 펼쳐짐
        public let price: Int // 가격
        public let formattedPrice: String // 포맷가격
    }
}
