//
//  PhotoListView.swift
//  BasicSwiftUI
//
//  Created by 한상진 on 2022/01/28.
//  Copyright © 2022 havi. All rights reserved.
//

import SwiftUI

struct PhotoListView: View {
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            Text("This is test view")
                .foregroundColor(.white)
                .padding()
                .edgesIgnoringSafeArea(.all)
        }
        
        
    }
}

struct PhotoListView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoListView()
    }
}
