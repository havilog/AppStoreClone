//
//  HeizelTest.swift
//  Heizel
//
//  Created by 한상진 on 2022/03/22.
//  Copyright © 2022 havi. All rights reserved.
//

import SwiftUI
import ThirdPartyManager
import ComposableArchitecture

public struct HeizelSearchHomeView: View {
    public let store: Store<HeizelSearchHomeState, HeizelSearchHomeAction>

    @State var searchText = ""
    @State var isSearching = false

    public init(store: Store<HeizelSearchHomeState, HeizelSearchHomeAction>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store) { viewStore in
            NavigationView() {
                SearchListView
            }
            .searchable(text: $searchText)
            .onSubmit(of: .search) {
                print(searchText)
                viewStore.send(.searchButtonTapped(term: searchText))
            }
        }
    }

    private var SearchListView: some View {
        WithViewStore(self.store) { viewStore in
            VStack {
                let count = viewStore.searchResult?.resultCount ?? 0
                List(0..<count, id: \.self) { num in
                    let item = viewStore.searchResult?.results[num]
                    NavigationLink(destination: HeizelSearchDetailView(item)) {
                        SearchListCell(item)
                    }
                }.navigationTitle("검색")
            }
        }
    }
}

struct SearchListCell: View {
    private var title: String?
    private var subtitle: String?
    private var imageUrl: URL?

    init(_ model: SearchItemResult?) {
        self.title = model?.trackName
        self.subtitle = "상세 설명"//model?.description
        self.imageUrl = model?.artworkUrl60
    }

    init(title: String? = nil, subtitle: String? = nil) {
        self.title = title
        self.subtitle = subtitle
    }

    var body: some View {
        HStack {
            AsyncImage(url: self.imageUrl){ image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .scaledToFit()
            .frame(width: 50, height: 50, alignment: .center)
            .cornerRadius(13)

            VStack(alignment: .leading, spacing: 3) {
                Text(self.title ?? "앱 이름")
                    .font(.system(size: 16, weight: .semibold, design: .default))
                    .lineLimit(1)

                Text(self.subtitle ?? "상세 설명")
                    .font(.system(size: 13))
                    .foregroundColor(.secondary)
            }
        }
    }
}

struct HeizelSearchHomeView_Previews: PreviewProvider {
    static var previews: some View {
        HeizelSearchHomeView(
            store: Store(
                initialState: HeizelSearchHomeState(),
                reducer: heizelSearchHomeReducer,
                environment: HeizelSearchHomeEnvironment()
            )
        )
    }
}
