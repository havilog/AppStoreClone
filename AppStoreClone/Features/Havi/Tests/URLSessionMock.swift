//
//  URLSessionMock.swift
//  HaviTests
//
//  Created by 한상진 on 2022/03/26.
//  Copyright © 2022 havi. All rights reserved.
//

import Foundation
import Havi

final class URLSessionMock: URLSessionProtocol {
    
    var shouldDataTaskSucceed: Bool
    
    init(shouldDataTaskSucceed: Bool) {
        self.shouldDataTaskSucceed = shouldDataTaskSucceed
    }
    
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        fatalError()
    }
    
    func data(for request: URLRequest, delegate: URLSessionTaskDelegate?) async throws -> (Data, URLResponse) {
        
        let successResponse = HTTPURLResponse(
            url: request.url!,
            statusCode: 200,
            httpVersion: "2",
            headerFields: nil
        )!
        
        let failureResponse = HTTPURLResponse(
            url: request.url!,
            statusCode: 402,
            httpVersion: "2",
            headerFields: nil
        )!
        
        if shouldDataTaskSucceed {
            let component = URLComponents(url: request.url!, resolvingAgainstBaseURL: false)!
            if component.queryItems!.contains(where: { $0.value == "카카오" }) {
                let data = readLocalFile(forName: "appInfoListKakaoBank")!
                return (data, successResponse)
            } else {
                return (.init(), successResponse)
            }
        } else {
            return (.init(), failureResponse)
        }
    }
    
    private func readLocalFile(forName name: String) -> Data? {
        do {
            let bundle = Bundle(for: type(of: self))
            if let bundlePath = bundle.path(forResource: name, ofType: "json"),
               let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }
        
        return nil
    }
    
}
