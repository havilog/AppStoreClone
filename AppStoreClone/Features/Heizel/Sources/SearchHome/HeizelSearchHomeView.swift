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
        NavigationView() {
            VStack {
                List(0..<40) { num in
                    SearchListCell()
                }
            }.navigationTitle("검색")
        }
        .searchable(text: $searchText)
        .onSubmit(of: .search) {
            print(searchText)
            //viewStore.send(.searchButtonTapped(keyword: searchQuery))
        }
    }

}

struct SearchListCell: View {
    private var title: String?
    private var subtitle: String?

    init(title: String? = nil, subtitle: String? = nil) {
        self.title = title
        self.subtitle = subtitle
    }

    var body: some View {
        HStack {
            Image(systemName: "heart.fill")
                .frame(width: 50, height: 50, alignment: .center)
                .cornerRadius(20)

            VStack(alignment: .leading, spacing: 3) {
                Text("앱 이름")
                    .font(.system(size: 16, weight: .semibold, design: .default))
                    .lineLimit(1)

                Text("설명 설명 설명 설명")
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
                environment: 
            )
        )
    }
}

//store: Store(
//    initialState: MainTabState(),
//    reducer: MainTabReducer,
//    environment: .live(environment: MainTabEnvironment())
//)
