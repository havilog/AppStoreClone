import Foundation
import SwiftUI

public struct FiveStarView: View {
  let rating: CGFloat
  let color: Color
  let width: CGFloat
  let height: CGFloat

  public init(
    rating: CGFloat,
    color: Color = .gray,
    width: CGFloat = 40,
    height: CGFloat = 40
  ) {
    self.rating = rating
    self.color = color
    self.width = width
    self.height = height
  }

  public var body: some View {
      RatingStar(rating: rating, color: color, width: width, height: height)
  }
}

struct ForegroundStar: View {
  let rating: CGFloat
  let color: Color
  let index: Int
  let width: CGFloat
  let height: CGFloat

  var maskRatio: CGFloat {
    let mask = rating - CGFloat(index)

    switch mask {
    case 1...: return 1
    case ..<0: return 0
    default: return mask
    }
  }

  init(rating: CGFloat, color: Color, index: Int, width: CGFloat, height: CGFloat) {
    self.rating = rating
    self.color = color
    self.index = index
    self.width = width
    self.height = height
  }

  var body: some View {
      Image(systemName: "star.fill")
      .resizable()
      .frame(width: width, height: height)
        .foregroundColor(self.color)
        .mask(
          Rectangle()
            .size(
              width: 40 * self.maskRatio,
              height: 40
            )
        )
    }
}

private struct RatingStar: View {
  let rating: CGFloat
  let color: Color
  let width: CGFloat
  let height: CGFloat

  init(rating: CGFloat, color: Color, width: CGFloat, height: CGFloat) {
    self.rating = rating
    self.color = color
    self.width = width
    self.height = height
  }

  var body: some View {
    HStack {
      ForEach(0..<5) { index in
        ZStack(alignment: .center) {
          Image(systemName: "star")
            .resizable()
            .frame(width: width, height: height)
            .foregroundColor(color)
          ForegroundStar(
            rating: self.rating,
            color: self.color,
            index: index,
            width: width,
            height: height)
        }
      }
    }
  }
}
