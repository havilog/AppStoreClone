//
//  ContentView.swift
//  Unsplash
//
//  Created by 한상진 on 2022/01/26.
//

import SwiftUI

public struct MainTabView: View {
    
    @State private var selection = 0
    
    public init() {
        configureTabBarAppearance()
    }
    
    public var body: some View {
        TabView(selection: $selection) {
            PhotoListView()
                .tabItem { Image(systemName: "photo") }
                .tag(0)
            
            PhotoSearchView()
                .tabItem { Image(systemName: "magnifyingglass") }
                .tag(1)
        }
        .accentColor(.white)
    }
    
    private func configureTabBarAppearance() {
        UITabBar.appearance().isTranslucent = false
        UITabBar.appearance().backgroundColor = .black
        UITabBar.appearance().unselectedItemTintColor = .gray
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}

// TODO: 이거로 한번에 tabItem 만들고 싶은데 모르겠음 ..,,

enum TabBarItem {
    case photoList
    case photoSearch
    
    var tagNumber: Int {
        switch self {
        case .photoList:
            return 0
        case .photoSearch:
            return 1
        }
    }
    
    var tabImage: Image {
        switch self {
        case .photoList:
            return Image(systemName: "photo")
        case .photoSearch:
            return Image(systemName: "magnifyingglass")
        }
    }
}
