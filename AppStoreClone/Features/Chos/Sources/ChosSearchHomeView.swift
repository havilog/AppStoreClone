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
  let store: Store<SearchState, SearchAction>

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
                                            send: SearchAction.onSearchKeyword("")))

          if !viewStore.recentlyKeyword.isEmpty {
            List(viewStore.recentlyKeyword) { keyword in
              Text(keyword)
            }
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

//struct ChosSearchHomeView_Previews: PreviewProvider {
//  static var previews: some View {
//    ChosSearchHomeView()
//  }
//}
