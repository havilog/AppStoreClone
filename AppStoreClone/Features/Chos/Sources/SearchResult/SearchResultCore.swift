//
//  SearchResultCore.swift
//  Chos
//
//  Created by 조상호 on 2022/05/05.
//  Copyright © 2022 havi. All rights reserved.
//

import Foundation
import ComposableArchitecture
import Combine

public struct SearchResultState: Equatable {
  var searchResults: [SearchDomain.AppData]
  
}
