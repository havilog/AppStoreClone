//
//  HeizelSearchDetailView.swift
//  Heizel
//
//  Created by Dozzing on 2022/05/05.
//  Copyright © 2022 havi. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

public struct HeizelSearchDetailView: View {
    var searchItem: SearchItemResult

    public init(_ item: SearchItemResult? = nil) {
        self.searchItem = item ?? SearchItemResult.kakao
    }

    public var body: some View {
        ScrollView() {
            VStack(alignment: .leading, spacing: 20) {
                titleView
                Divider()
                featureView
                Divider()
                screenshotView
                Divider()
                ratingView
                Divider()
            }.padding(.leading, 20)
        }
    }

    private var titleView: some View {
        HStack(alignment: .center, spacing: 30) {
            AsyncImage(url: searchItem.artworkUrl100){ image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .scaledToFit()
            .frame(width: 100, height: 100, alignment: .center)
            .cornerRadius(15)

            VStack(alignment: .leading, spacing: 5) {
                Text(searchItem.trackName)
                    .font(.system(size: 23, weight: .semibold, design: .default))
                Text("상세 설명")
                    .font(.system(size: 16))
                    .foregroundColor(.secondary)
            }
        }

    }

    private var featureView: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("새로운 기능")
                .font(.system(size: 20, weight: .semibold, design: .default))

            Text("버전 \(searchItem.version)")
                .font(.system(size: 16))
                .foregroundColor(.secondary)

            Text(searchItem.releaseNotes ?? "")
                .font(.system(size: 16))
                .lineSpacing(3)
                //.foregroundColor(.secondary)
        }
    }

    private var screenshotView: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("미리보기")
                .font(.system(size: 20, weight: .semibold, design: .default))

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .center, spacing: 10) {
                    ForEach(searchItem.screenshotUrls, id: \.self) { url in
                        ScreenshotCell(imageUrl: url)
                    }
                }
            }
        }
    }

    private var ratingView: some View {
        HStack {
            VStack(alignment: .center, spacing: 7) {
                Text("평가 및 리뷰")
                    .font(.system(size: 20, weight: .semibold, design: .default))

                Text(String(format: "%.1f", searchItem.averageUserRating!))
                    .font(.system(size: 50, weight: .bold, design: .default))
                    .foregroundColor(.gray)

                Text("(최고 5점)")
                    .foregroundColor(.secondary)
            }
        }
    }
}

struct ScreenshotCell: View {
    private var imageUrl: URL?

    init(imageUrl: URL? = nil) {
        self.imageUrl = imageUrl
    }

    var body: some View {
        AsyncImage(url: self.imageUrl) { image in
            image.resizable()
        } placeholder: {
            ProgressView()
        }
        .scaledToFit()
        .frame(width: 180, height: 320, alignment: .center)
        .cornerRadius(15)
    }
}

struct HeizelSearchDetailView_Previews: PreviewProvider {
    static var previews: some View {
        HeizelSearchDetailView()
    }
}
