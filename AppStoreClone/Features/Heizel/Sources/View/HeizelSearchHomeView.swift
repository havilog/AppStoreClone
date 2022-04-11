//
//  HeizelTest.swift
//  Heizel
//
//  Created by 한상진 on 2022/03/22.
//  Copyright © 2022 havi. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

public struct HeizelSearchHomeView: View {

    @State var searchText = ""
    @State var isSearching = false
    
    public init() {
        
    }
    
    public var body: some View {
        NavigationView() {
            ScrollView {
                SearchBar(searchText: $searchText, isSearching: $isSearching)
            }.navigationTitle("검색")
        }
    }

}

struct contentView: View {
    var body: some View {
        VStack() {
            Text("??")
        }.navigationTitle("hi")
    }
}

struct HeizelSearchHomeView_Previews: PreviewProvider {
    static var previews: some View {
        HeizelSearchHomeView()
    }
}

struct SearchBar: View {

    @Binding var searchText: String
    @Binding var isSearching: Bool

    var body: some View {
        HStack {
            HStack {
                TextField("Search terms here", text: $searchText)
                .padding(.leading, 24)
                .onSubmit {
                    print(searchText)
                }
            }
            .padding()
            .background(Color(.systemGray4))
            .cornerRadius(6)
            .padding(.horizontal)
            .onTapGesture(perform: {
                isSearching = true
            })
            .overlay(
                HStack {
                    Image(systemName: "magnifyingglass")
                    Spacer()

                    if isSearching {
                        Button(action: { searchText = "" }, label: {
                            Image(systemName: "xmark.circle.fill")
                                .padding(.vertical)
                        })
                    }
                }.padding(.horizontal, 32)
                    .foregroundColor(.gray)
            )
            .transition(.move(edge: .trailing))
            .animation(.spring(), value: isSearching)

            if isSearching {
                Button(action: {
                    isSearching = false
                    searchText = ""

                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }, label: {
                    Text("Cancel")
                        .padding(.trailing)
                        .padding(.leading, 0)
                })
                    .transition(.move(edge: .trailing))
                    .animation(.spring(), value: isSearching)
            }
        }
    }
}
