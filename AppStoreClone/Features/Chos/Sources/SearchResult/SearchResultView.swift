//
//  SearchResultView.swift
//  Chos
//
//  Created by 조상호 on 2022/05/11.
//  Copyright © 2022 havi. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

public struct SearchResultView: View {
  let store: Store<SearchResultState, SearchResultAction>

  public init(store: Store<SearchResultState, SearchResultAction>) {
    self.store = store
  }

  public var body: some View {
    WithViewStore(self.store) { viewStore in
      NavigationView {
        VStack {
          
        }
      }
    }
  }
}

fileprivate struct SearchResultComponent {
  @ViewBuilder
  static func renderTitleView(
    appInfo: SearchDomain.AppData,
    onTapOpenAction: @escaping () -> Void,
    onTapShareAction: @escaping () -> Void) -> some View {
      HStack {
        AsyncImage(
          url: .init(string: appInfo.artworkUrl60),
          content: { image in
            image
              .mask {
                RoundedRectangle(cornerRadius: 8)
                  .frame(width: 80, height: 80)
              }
          },
          placeholder: {
            Rectangle()
              .frame(width: 80, height: 80)
              .foregroundColor(.gray)
          })

        VStack {
          Text(appInfo.trackName)
            .bold()
            .multilineTextAlignment(.leading)

          Text(appInfo.sellerName)
        }
      }
  }
}
