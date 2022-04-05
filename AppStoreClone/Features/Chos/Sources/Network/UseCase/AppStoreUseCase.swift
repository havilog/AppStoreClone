//
//  AppStoreUseCase.swift
//  Chos
//
//  Created by 조상호 on 2022/04/05.
//  Copyright © 2022 havi. All rights reserved.
//

import Foundation
import Combine

public protocol AppStoreUseCase {
  var searchKeyword: (SearchDomain.Request.SearchRequest) -> AnyPublisher<SearchDomain.SearchResult, CompositingErrorDomain> { get }
}
