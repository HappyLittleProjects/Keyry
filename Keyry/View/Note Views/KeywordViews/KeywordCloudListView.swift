//
//  KeywordListView.swift
//  Keyry
//
//  Created by Linda Lau on 4/20/24.
//

import SwiftUI

struct KeywordCloudListView: View {
  @Environment(\.editMode) private var editMode

  let keywords: [String]

  @State private var totalHeight = CGFloat.zero

  var body: some View {
    VStack {
      GeometryReader { geometry in
        generateContent(in: geometry)
      }
    }
    .frame(height: totalHeight)
  }

  private func generateContent(in geometry: GeometryProxy) -> some View {
    var width = CGFloat.zero
    var height = CGFloat.zero

    return ZStack(alignment: .topLeading) {
      ForEach(keywords, id: \.self) { keyword in
        KeywordCellView(label: keyword, editMode: editMode!.wrappedValue.isEditing)
          .padding([.horizontal, .vertical], 3)
          .alignmentGuide(.leading, computeValue: { dimensions in
            // start next row
            if (abs(width - dimensions.width) > geometry.size.width) {
              width = 0
              height -= dimensions.height
            }

            let result = width
            if keyword == keywords.last! {
              width = 0
            } else {
              width -= dimensions.width
            }
            return result
          })
          .alignmentGuide(.top, computeValue: { d in
            let result = height
            if keyword == keywords.last! {
              height = 0
            }
            return result
          })
      }
    }
    .background(viewHeightReader($totalHeight))
  }

  private func viewHeightReader(_ binding: Binding<CGFloat>) -> some View {
    GeometryReader{ geometry -> Color in
      let rect = geometry.frame(in: .local)
      DispatchQueue.main.async {
        binding.wrappedValue = rect.size.height
      }

      return .clear
    }
  }
}

#Preview {

  let keywords: [String] = [
    "word 0",
    "word 1",
    "word 2",
    "word 3",
    "word 4",
    "word 5",
    "word 6",
    "word 7",
    "word 8",
    "word 9",
    "word 10",
    "word 11",
    "word 12",
    "word 13",
    "word 14",
    "word 15",
    "word 16",
    "word 17",
    "word 18",
    "word 19",
    "long word 12345"
  ]

  return KeywordCloudListView(keywords: keywords)
    .environment(\.editMode, Binding.constant(EditMode.active))
}
