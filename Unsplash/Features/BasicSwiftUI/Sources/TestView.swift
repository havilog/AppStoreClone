//
//  ContentView.swift
//  Unsplash
//
//  Created by 한상진 on 2022/01/26.
//

import SwiftUI

public struct TestView: View {
    public var body: some View {
        Text("This is test view")
            .padding()
            .edgesIgnoringSafeArea(.all)
    }
    
    public init() { }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
