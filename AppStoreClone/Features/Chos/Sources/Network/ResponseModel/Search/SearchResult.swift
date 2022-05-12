//
//  SearchResult.swift
//  Chos
//
//  Created by 조상호 on 2022/03/29.
//  Copyright © 2022 havi. All rights reserved.
//

import Foundation

public enum SearchDomain {
  
  public struct SearchResult: Equatable, Codable {
    public init(resultCount: Int, results: [AppData]) {
      self.resultCount = resultCount
      self.results = results
    }
    
    public let resultCount: Int
    public let results: [AppData]
  }
  
  public struct AppData: Equatable, Codable, Identifiable {
    public init(
      artworkUrl60: String,
      artworkUrl100: String,
      artwrokUrl512: String,
      screenshotUrls: [String],
      supportedDevices: [String],
      minimumOsVersion: String,
      trackName: String,
      averageUserRating: Double,
      averageUserRatingForCurrentVersion: Double,
      contentAdvisoryRating: String,
      userRatingCount: Int,
      releaseNotes: String?,
      sellerName: String)
    {
      self.artworkUrl60 = artworkUrl60
      self.artworkUrl100 = artworkUrl100
      self.artworkUrl512 = artwrokUrl512
      self.screenshotUrls = screenshotUrls
      self.supportedDevices = supportedDevices
      self.minimumOsVersion = minimumOsVersion
      self.trackName = trackName
      self.averageUserRating = averageUserRating
      self.averageUserRatingForCurrentVersion = averageUserRatingForCurrentVersion
      self.contentAdvisoryRating = contentAdvisoryRating
      self.userRatingCount = userRatingCount
      self.releaseNotes = releaseNotes
      self.sellerName = sellerName
    }
    
    public let artworkUrl60: String
    public let artworkUrl100: String
    public let artworkUrl512: String
    public let screenshotUrls: [String]
    public let supportedDevices: [String]
    public let minimumOsVersion: String
    public let trackName: String
    public let averageUserRating: Double
    public let averageUserRatingForCurrentVersion: Double
    public let contentAdvisoryRating: String
    public let userRatingCount: Int
    public let releaseNotes: String?
    public let sellerName: String

    public var id: String {
      artworkUrl60 + trackName
    }
  }
}

extension SearchDomain {
  public enum Request {
    public struct SearchRequest: Codable {
      public let term: String
      public let entity: String
      public let country: String
      public let lang: String
      
      public init(term: String, entity: String, country: String, lang: String) {
        self.term = term
        self.entity = entity
        self.country = country
        self.lang = lang
      }
    }
  }
}

extension SearchDomain.AppData {
  static func defaultValue() -> Self {
    .init(
      artworkUrl60: "",
      artworkUrl100: "",
      artwrokUrl512: "",
      screenshotUrls: [],
      supportedDevices: [],
      minimumOsVersion: "",
      trackName: "",
      averageUserRating: .zero,
      averageUserRatingForCurrentVersion: .zero,
      contentAdvisoryRating: "",
      userRatingCount: .zero,
      releaseNotes: .none,
      sellerName: "")
  }
}
