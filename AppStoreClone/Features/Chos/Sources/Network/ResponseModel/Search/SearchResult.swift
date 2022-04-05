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
  
  public struct AppData: Equatable, Codable {
    public init(
      artworkUrl60: String,
      artworkUrl100: String,
      artwrokUrl512: String,
      screenshotUrls: [String],
      supportedDevices: [String],
      minimumOsVersion: String,
      trackName: String,
      averageUserRating: String,
      averageUserRatingForCurrentVersion: String,
      contentAdvisoryRating: String,
      userRatingCount: Int,
      releaseNotes: String)
    {
      self.artworkUrl60 = artworkUrl60
      self.artworkUrl100 = artworkUrl100
      self.artwrokUrl512 = artwrokUrl512
      self.screenshotUrls = screenshotUrls
      self.supportedDevices = supportedDevices
      self.minimumOsVersion = minimumOsVersion
      self.trackName = trackName
      self.averageUserRating = averageUserRating
      self.averageUserRatingForCurrentVersion = averageUserRatingForCurrentVersion
      self.contentAdvisoryRating = contentAdvisoryRating
      self.userRatingCount = userRatingCount
      self.releaseNotes = releaseNotes
    }
    
    public let artworkUrl60: String
    public let artworkUrl100: String
    public let artwrokUrl512: String
    public let screenshotUrls: [String]
    public let supportedDevices: [String]
    public let minimumOsVersion: String
    public let trackName: String
    public let averageUserRating: String
    public let averageUserRatingForCurrentVersion: String
    public let contentAdvisoryRating: String
    public let userRatingCount: Int
    public let releaseNotes: String
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
