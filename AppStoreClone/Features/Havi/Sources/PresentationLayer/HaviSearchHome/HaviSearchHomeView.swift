//
//  HaviSearchHomeView.swift
//  Havi
//
//  Created by 한상진 on 2022/03/29.
//  Copyright © 2022 havi. All rights reserved.
//

import SwiftUI

import ThirdPartyManager
import ComposableArchitecture

public struct HaviSearchHomeView: View {
    
    @State var searchQuery = ""
    
    public let store: Store<HaviSearchHomeState, HaviSearchHomeAction>
    
    public init(store: Store<HaviSearchHomeState, HaviSearchHomeAction>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store) { viewStore in
            NavigationView {
                VStack {
                    Text("Hello, Havi!")
                }
                .navigationTitle("검색")
            }
            .searchable(text: $searchQuery)
            .onSubmit(of: .search) {
                viewStore.send(.searchButtonTapped(keyword: searchQuery))
            }
        }
    }
} 

//struct HaviSearchHomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HaviSearchHomeView()
//    }
//}
