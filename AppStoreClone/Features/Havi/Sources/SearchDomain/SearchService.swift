//
//  SearchService.swift
//  Havi
//
//  Created by 한상진 on 2022/03/31.
//  Copyright © 2022 havi. All rights reserved.
//

import Foundation

import Core

public protocol SearchService {
    func searchApp(with term: String) async throws -> SearchAPIResult
}

public struct SearchServiceImpl: SearchService {
    private let network: NetworkRepository
    
    public init(
        network: NetworkRepository
    ) {
        self.network = network
    }
    
    public func searchApp(with term: String) async throws -> SearchAPIResult {
        return try await network.reqeust(
            with: Endpoint.searchApp(term: term), 
            for: SearchAPIResult.self
        )
    }
}
