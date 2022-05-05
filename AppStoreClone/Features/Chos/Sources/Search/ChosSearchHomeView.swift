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
  @State private var viewState: SearchViewState = .homeView
  @Environment(\.isSearching) var isSearching

  public init(store: Store<ChosSearchState, ChosSearchAction>) {
      self.store = store
  }

  public var body: some View {
    WithViewStore(self.store) { viewStore in
      NavigationView {
        VStack {
          switch viewState {
          case .homeView:
            SearchComponent.renderHomeView(
              recentlyKeyword: viewStore.recentlyKeyword,
              onTapAction: {
                viewStore.send(.onSearchKeyword($0))
                viewState = .showSearchResult
              })
          case .showMatchKeyword:
            SearchComponent.renderKeywordMatchingComponent(
              matchingKeywords: viewStore.filteredRecentlyKeyword,
              onTapSearchAction: {
                viewStore.send(.onSearchKeyword($0))
                viewState = .showSearchResult
              })
          case .showSearchResult:
            SearchComponent.renderSearchResultView(
              resultItems: viewStore.searchResults,
              onTapAction: {
                viewStore.send(.onTapResult($0))
              })
          }
        }
        .navigationTitle("검색")
      }
      .navigationViewStyle(.stack)
      .searchable(text: .init(
        get: { viewStore.searchKeyword },
        set: {
          viewStore.send(.onChangedSearchKeyword($0))
          viewState = $0.isEmpty ? .homeView : .showMatchKeyword
        })
      )
      .onSubmit(of: .search) {
        viewStore.send(.onSearchKeyword(viewStore.searchKeyword))
        viewState = .showSearchResult
      }
    }
  }
}

fileprivate struct SearchComponent {
  @ViewBuilder
  static func renderHomeView(
    recentlyKeyword: [String],
    onTapAction: @escaping (String) -> Void) -> some View {
    VStack {
      HStack {
        Text("최근 검색어")
          .font(.title3)
          .fontWeight(.bold)

        Spacer()
      }

      ForEach(recentlyKeyword, id: \.self) { item in
        renderRecentlyComponent(
          onTapAction: { onTapAction($0) },
          item: item)
      }

      Spacer()
    }
    .padding(20)
    .animation(.easeInOut)
  }

  static func renderKeywordMatchingComponent(
    matchingKeywords: [String],
    onTapSearchAction: @escaping (String) -> Void) -> some View {
      ScrollView {
        LazyVStack {
          ForEach(matchingKeywords, id: \.self) { item in
            renderItemComponent(
              onTapAction: { onTapSearchAction($0) },
              item: item)
          }
        }
        .padding()
      }
  }

  static func renderSearchResultView(
    resultItems: [SearchDomain.AppData],
    onTapAction: @escaping (SearchDomain.AppData) -> Void) -> some View {
      ScrollView {
        LazyVStack {
          ForEach(resultItems) { item in
            renderAppDataComponent(
              appData: item,
              onTapAction: { onTapAction($0) },
              onTapOpenAction: { _ in })
          }
        }
      }
  }

  @ViewBuilder
  private static func renderItemComponent(
    onTapAction: @escaping (String) -> Void,
    item: String) -> some View {
      Button(action: { onTapAction(item) }) {
        VStack {
          HStack {
            Image(systemName: "magnifyingglass")
              .foregroundColor(.gray)
            Text(item)
              .font(.system(size: 20))
              .lineLimit(1)
              .truncationMode(.middle)
            Spacer()
          }
          .foregroundColor(.black)
          .padding(8)

          Divider()
        }
      }
    }

  private static func renderRecentlyComponent(
    onTapAction: @escaping (String) -> Void,
    item: String) -> some View {
      Button(action: { onTapAction(item) }) {
        VStack {
          HStack {
            Text(item)
              .font(.system(size: 16))
              .foregroundColor(.blue)

            Spacer()
          }
          .padding(8)

          Divider()
        }
      }
    }

  private static func renderAppDataComponent(
    appData: SearchDomain.AppData,
    onTapAction: @escaping (SearchDomain.AppData) -> Void,
    onTapOpenAction: @escaping (SearchDomain.AppData) -> Void) -> some View {
      Button(action: { onTapAction(appData) }) {
        HStack(alignment: .center) {
          AsyncImage(url: .init(string: appData.artworkUrl60),
                     content: { image in
            image
              .mask {
                RoundedRectangle(cornerRadius: 6)
                  .frame(width: 60, height: 60)
              }
          }, placeholder: {
            Rectangle()
              .frame(width: 60, height: 60)
              .foregroundColor(.gray)
          })

          VStack(alignment: .leading) {
            Text(appData.trackName)
              .bold()

            Text(appData.trackName)
              .foregroundColor(.gray)
              .lineLimit(1)
              .truncationMode(.tail)
            
            FiveStarView(rating: appData.averageUserRating, width: 15, height: 15)
          }

          Spacer()
        }
      }
      .padding()
    }
}

enum SearchViewState {
  case homeView
  case showMatchKeyword
  case showSearchResult
}
