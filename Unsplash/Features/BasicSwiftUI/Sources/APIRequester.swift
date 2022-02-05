//
//  APIRequester.swift
//  BasicSwiftUI
//
//  Created by 한상진 on 2022/02/04.
//  Copyright © 2022 havi. All rights reserved.
//

import Foundation

struct APIRequester {
    func requestPhotoList() {
        let authorizationValue: String = "Client-ID Oa7aWQbJmG_a1ONnUnjozJuz2IMG5bjbQUGGQZxSvUU"
        let urlString: String = "https://api.unsplash.com/photos"
        let url: URL = .init(string: urlString)!
        var request: URLRequest = .init(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
        }
    }
}
