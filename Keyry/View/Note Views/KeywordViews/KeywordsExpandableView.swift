//
//  KeywordsListView.swift
//  Keyry
//
//  Created by Linda Lau on 3/19/24.
//

import SwiftUI

struct KeywordsExpandableView: View {
  let keywords: [String]
  
  @State private var isExpandable: Bool

  @Namespace private var namespace
  @State private var isExpanded = false

  init(keywords: [String], isExpandable: Bool = true) {
    self.keywords = keywords
    self.isExpandable = isExpandable
  }

  var body: some View {
    VStack (alignment: .leading) {

      Text("Keywords:")
        .font(.caption2)

      if isExpanded || !isExpandable {
        expandedView()
      }
      else {
        miniView()
      }

      ZStack {
        Divider()

        if isExpandable {
          Image(systemName: "chevron.down.circle")
            .symbolRenderingMode(.palette)
            .foregroundStyle(Color.accentColor)
//            .padding()
            .background(.white)
            .clipShape(Circle())
            .rotationEffect(.degrees(isExpanded ? 180 : 0))
        }
      }
    }
    .onTapGesture {
      didTap()
    }
  }

  @ViewBuilder
  private func miniView() -> some View {
    ZStack {
      KeywordScrollList(keywords: keywords)
        .matchedGeometryEffect(id: "view", in: namespace)
    }
    .mask(
      RoundedRectangle(cornerRadius: 15, style: .continuous)
        .matchedGeometryEffect(id: "mask", in: namespace)
    )
  }

  @ViewBuilder
  private func expandedView() -> some View {
    ZStack {
      KeywordCloudListView(keywords: keywords)
        .matchedGeometryEffect(id: "view", in: namespace)
    }
    .mask(
      RoundedRectangle(cornerRadius: 15, style: .continuous)
        .matchedGeometryEffect(id: "mask", in: namespace)
    )
  }

  private func didTap() {
//    guard isExpandable else {
//      return
//    }
    withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
      isExpanded.toggle()
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

  return KeywordsExpandableView(keywords: keywords, isExpandable: true)
}
