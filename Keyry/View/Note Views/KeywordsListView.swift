//
//  KeywordsListView.swift
//  Keyry
//
//  Created by Linda Lau on 3/19/24.
//

import SwiftUI

struct KeywordsListView: View {
  @Binding var keywords: [String]

  var body: some View {
    List {
      ForEach(keywords, id: \.self) { keyword in
        Text(keyword)
      }
    }
  }
}

#Preview {
  @State var keywords: [String] = []

  return KeywordsListView(keywords: $keywords)
}
