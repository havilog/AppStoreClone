//
//  SearchUseCase.swift
//  Heizel
//
//  Created by Dozzing on 2022/04/10.
//  Copyright © 2022 havi. All rights reserved.
//

import Foundation
import Combine

class SearchUseCase {
    static func searchApps(with term: String) -> AnyPublisher<SearchResult, Error> {
        let urlString = "\(URL.Host.appStore)/search"
        let parameters: [String: String] = ["term": term]
        return Network.shared.request(urlString: urlString, parameters: parameters)
    }
}
