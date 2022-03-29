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

struct MainTabView: View {
    var body: some View {
        TabView {
            ChosTab
            HaviTab
            HeizelTab
        }
    }
    
    private var ChosTab: some View {
        ChosSearchHomeView()
            .tabItem { 
                Image(systemName: "magnifyingglass")
                Text("Chos")
            }
    }
    
    private var HaviTab: some View {
        HaviSearchHomeView()
            .tabItem { 
                Image(systemName: "magnifyingglass")
                Text("Havi")
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

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
