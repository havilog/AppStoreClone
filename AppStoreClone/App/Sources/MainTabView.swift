//
//  TabView.swift
//  AppStoreClone
//
//  Created by 한상진 on 2022/03/25.
//  Copyright © 2022 havi. All rights reserved.
//

import SwiftUI

import Havi
import Heizel
import Chos
import Core
import ThirdPartyManager

import ComposableArchitecture

struct MainTabView: View {
    
    let store: Store<MainTabState, MainTabAction>
    
    var body: some View {
        WithViewStore(self.store.stateless) { _ in
            TabView {
                ChosTab
                HaviTab
                HeizelTab
            }    
        }
    }
    
    private var ChosTab: some View {
        ChosSearchHomeView(
          store: store.scope(
            state: \.chosSearchState,
            action: MainTabAction.chosAction
            )
        )
            .tabItem { 
                Image(systemName: "magnifyingglass")
                Text("Chos")
            }
    }
    
    private var HaviTab: some View {
        HaviSearchHomeView(
            store: store.scope(
                state: \.haviSearchState, 
                action: MainTabAction.haviAction
            )
        )
        .tabItem { 
            Label("Havi", systemImage: "magnifyingglass")
        }
    }
    
    private var HeizelTab: some View {
        HeizelSearchHomeView()
            .tabItem { 
                Image(systemName: "magnifyingglass")
                Text("Heizel")
            }
    }
}

//struct TabView_Previews: PreviewProvider {
//    static var previews: some View {        MainTabView(
//            store: .init(
//                initialState: .init(), 
//                reducer: MainTabReducer, 
//                environment: .init()
//            )
//        )
//    }
//}
