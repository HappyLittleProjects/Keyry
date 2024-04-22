//
//  KeywordScrollList.swift
//  Keyry
//
//  Created by Linda Lau on 4/20/24.
//

import SwiftUI

struct KeywordScrollList: View {
  let keywords: [String]

  var body: some View {
    ScrollView (.horizontal) {
      HStack {
        ForEach(keywords, id: \.self) { keyword in
          KeywordCellView(label: keyword, editMode: false)
        }
      }
    }
    .scrollIndicators(.never)
    .clipShape(Capsule())
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

  return KeywordScrollList(keywords: keywords)
}
