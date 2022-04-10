//
//  UnsplashApp.swift
//  Unsplash
//
//  Created by 한상진 on 2022/01/26.
//

import SwiftUI
import ComposableArchitecture

@main
struct AppStoreClone: App {
    var body: some Scene {
        WindowGroup {
            MainTabView(
                store: Store(
                    initialState: MainTabState(),
                    reducer: MainTabReducer,
                    environment: .live(environment: MainTabEnvironment())
                )
            )
        }
    }
}
