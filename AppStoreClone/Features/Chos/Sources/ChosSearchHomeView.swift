//
//  ChosTest.swift
//  Chos
//
//  Created by 한상진 on 2022/03/22.
//  Copyright © 2022 havi. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

public struct ChosSearchHomeView: View {
  let store: Store<ChosSearchState, ChosSearchAction>

  public init(store: Store<ChosSearchState, ChosSearchAction>) {
      self.store = store
  }

  public var body: some View {
    WithViewStore(self.store) { viewStore in
      NavigationView {
        VStack {
          HStack {
            Text("검색")
              .font(.largeTitle)

            Spacer()
          }
          SearchBar(text: viewStore.binding(get: \.searchKeyword,
                                            send: ChosSearchAction.onSearchKeyword("")))

          if !viewStore.recentlyKeyword.isEmpty {
          }
        }
      }
    }
    Text("Hello, Chos!")
  }
}

//extension ChosSearchHomeView {
//  @ViewBuilder
//  func
//}
