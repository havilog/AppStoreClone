//
//  Endpoint.swift
//  Core
//
//  Created by 한상진 on 2022/03/25.
//  Copyright © 2022 havi. All rights reserved.
//

import Foundation
import XCTest
@testable import Havi

class NetworkRepositoryTests: XCTestCase {
    
    var sut: NetworkRepository!
    var urlSessionMock: URLSessionProtocol!
    
    override func setUpWithError() throws {
        sut = NetworkRepositoryImpl(with: URLSessionMock(shouldDataTaskSucceed: true))
    }
    
    override func tearDownWithError() throws {
        
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

extension NetworkRepositoryTests {
    func test_endpoint와_decodeType이_잘들어가면_성공() async throws {
        // given
        let endpoint = Endpoint.searchApp(term: "카카오")
        let data = readLocalFile(forName: "appInfoListKakaoBank")!
        let mockResult = try! JSONDecoder().decode(SearchAPIResult.self, from: data)
        
        // when
        let result = try await sut.reqeust(with: endpoint, for: SearchAPIResult.self)
        
        // then
        XCTAssertEqual(result, mockResult)
    }
    
    func test_endpoint를_잘못넣으면_실패() async throws {
        //given
        let endpoint = Endpoint.searchApp(term: "잘못된 term")
        
        do {
            // when
            _ = try await sut.reqeust(with: endpoint, for: SearchAPIResult.self)    
        } catch {
            // then
            XCTAssertEqual(error as! NetworkError, NetworkError.unableToDecode)
        }        
    }
    
    func test_decodeType을_잘못넣으면_실패() async throws {
        //given
        let endpoint = Endpoint.searchApp(term: "카카오")
        
        do {
            // when
            _ = try await sut.reqeust(with: endpoint, for: [SearchAPIResult].self)    
        } catch {
            // then
            XCTAssertEqual(error as! NetworkError, NetworkError.unableToDecode)
        }        
    }
}

