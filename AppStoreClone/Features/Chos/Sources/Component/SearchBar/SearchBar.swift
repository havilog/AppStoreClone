import Foundation
import SwiftUI

struct SearchBar {
  @Binding var text: String
  @State var isEditing: Bool = false

  public init(text: Binding<String>) {
    self._text = text
  }

  private enum Const {
    static let contentsPadding: EdgeInsets = .init(top: 8, leading: 16, bottom: 8, trailing: 16)
  }
}

extension SearchBar: View {
  var body: some View {
    HStack {
      TextField("검색", text: $text)
        .padding()
        .padding(.horizontal, 25)
        .background(Color(.systemGray6))
        .cornerRadius(8)
        .overlay(
          HStack {
            Image(systemName: "magnifyingglass")
              .foregroundColor(.gray)
              .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
              .padding(.leading, 8)

            if isEditing {
              Button(action: {
                text = ""
              }) {
                Image(systemName: "multiply.circle.fill")
                  .foregroundColor(.gray)
                  .padding(.trailing, 8)
              }
            }
          }
        )
        .onTapGesture { isEditing = true }

      if isEditing {
        Button(action: {
          isEditing = false
          text = ""
        }) {
          Text("취소")
        }
        .transition(.move(edge: .trailing))
        .animation(.easeOut)
      }
    }
    .padding(.init(top: 8, leading: 16, bottom: 8, trailing: 16))
    .transition(.move(edge: .trailing))
    .animation(.easeOut)
  }
}

struct SearchBar_Previews: PreviewProvider {
  static var previews: some View {
    SearchBar(text: .init(get: { "" }, set: { _ in }))
  }
}
