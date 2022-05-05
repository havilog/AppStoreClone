//
//  SearchClient.swift
//  Havi
//
//  Created by 한상진 on 2022/05/05.
//  Copyright © 2022 havi. All rights reserved.
//

import Core
import ComposableArchitecture

public struct SearchClient {
    var searchQuery: (String) -> Effect<SearchAPIResult, SearchFailure>
    
    public struct SearchFailure: Error, Equatable {
        init(error: Error) {
            // do some porting
        }
    }
}

extension SearchClient {
    public static var live: Self {
        return SearchClient(
            searchQuery: { term in
                Effect.task { 
                    try await NetworkRepositoryImpl(with: URLSession.shared).reqeust(
                        with: Endpoint.searchApp(term: term), 
                        for: SearchAPIResult.self
                    )
                }
                .mapError(SearchFailure.init)
                .eraseToEffect()    
            }
        )
    }
}
