//
//  PhotoAPI.swift
//  Network
//
//  Created by 한상진 on 2022/02/05.
//  Copyright © 2022 havi. All rights reserved.
//

import Foundation
import Moya

enum PhotoAPI {
    case fetchPhotoList(page: Int)
}

extension PhotoAPI: TargetType {
    var baseURL: URL {
        return .init(string: "https://api.unsplash.com/photos")!
    }
    
    var path: String {
        switch self {
        case .fetchPhotoList:
            return "/photos"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchPhotoList:
            return .get
        }
    }
    
    var sampleData: Data {
        return .init()
    }
    
    var task: Task {
        switch self {
        case let .fetchPhotoList(page):
            return .requestParameters(parameters: [
                "page": page,
                "per_page": 20,
                "order_by": "latest"
            ], encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return ["Authorization": "Client-ID Oa7aWQbJmG_a1ONnUnjozJuz2IMG5bjbQUGGQZxSvUU"]
    }
    
}
