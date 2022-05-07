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
    
    private let gridItemLayout: [GridItem] = [GridItem(.flexible())]
    
    private let store: Store<HaviSearchHomeState, HaviSearchHomeAction>
    @ObservedObject private var viewStore: ViewStore<HaviSearchHomeState, HaviSearchHomeAction>
    
    public init(store: Store<HaviSearchHomeState, HaviSearchHomeAction>) {
        self.store = store
        self.viewStore = ViewStore(store)
    }
    
    public var body: some View {
        NavigationView {
            switch viewStore.viewState {
            case .suggestion:
                suggestionsView
                
            case .result:
                searchResultListView
            }
        }
        .navigationViewStyle(.stack)
        .searchable(
            text: viewStore.binding(
                get: \.query, 
                send: HaviSearchHomeAction.searchKeywordChanged
            ),
            prompt: "게임, 앱, 스토리 등"
        )
        .onSubmit(of: .search) {
            viewStore.send(.searchButtonTapped)
        } 
    }
    
    private var searchResultListView: some View {
        ScrollView {
            LazyVGrid(columns: gridItemLayout) { 
                ForEach(viewStore.state.searchResults, id: \.self) { result in
                    searchResultCell(item: result)
                }
            }
        }
        .navigationTitle("검색")
    }
    
    private var suggestionsView: some View {
        List {
            ForEach(viewStore.searchHistory) { history in
                Text(history.id)
                    .onTapGesture {
                        viewStore.send(.searchKeywordChanged(history.id))
                        viewStore.send(.searchButtonTapped)
                    }
            }
        }
        .listStyle(.plain)
        .navigationTitle("검색")
    }
    
    private func searchResultCell(item: SearchAPIResult.SearchResult) -> some View {
        HStack {
            asyncIconImageView(item: item)
            
            titleDescriptionStarVStack(item: item)
            
            Spacer()
            
            openButton
        }
        .padding(.horizontal, 30)
        .padding(.vertical, 15)
    }
    
    private func asyncIconImageView(item: SearchAPIResult.SearchResult) -> some View {
        AsyncImage(url: item.artworkUrl512) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
        } placeholder: { 
            ProgressView()
        }
        .frame(width: 70, height: 70)
        .mask(RoundedRectangle(cornerRadius: 16))
    }
    
    private func titleDescriptionStarVStack(item: SearchAPIResult.SearchResult) -> some View {
        VStack(alignment: .leading, spacing: 3) {
            Text(item.trackName)
                .font(.system(size: 17))
                .foregroundColor(Color(UIColor.black))
            
            Text(item.trackName)
                .font(.system(size: 14))
                .foregroundColor(Color(UIColor.darkGray))
            
            FiveStarView(rating: item.averageUserRating, width: 15, height: 15)
        }
    }
    
    private var openButton: some View {
        Button("열기") { }
            .frame(width: 70, height: 30, alignment: .center)
            .background(Color(UIColor.systemGray5))
            .clipShape(Capsule())
            .foregroundColor(.blue)
    }
} 

struct HaviSearchHomeView_Previews: PreviewProvider {
    static var previews: some View {
        HaviSearchHomeView(
            store: .init(
                initialState: HaviSearchHomeState(), 
                reducer: haviSearchHomeReducer,
                environment: HaviSearchHomeEnvironment(searchClient: .live, mainQueue: .main)
            )
        )
    }
}
