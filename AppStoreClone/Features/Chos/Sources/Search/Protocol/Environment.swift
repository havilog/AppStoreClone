//
//  Environment.swift
//  Chos
//
//  Created by 조상호 on 2022/03/29.
//  Copyright © 2022 havi. All rights reserved.
//

import Foundation

public protocol SearchEnvironmentType {
  func getSearchResult(keyword: String) -> SearchDomain.SearchResult
}
