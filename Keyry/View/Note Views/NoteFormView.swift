//
//  NewNoteFormView.swift
//  Keyry
//
//  Created by Linda Lau on 2/28/24.
//

import SwiftUI

struct NoteFormView: View {
  @Binding var title: String
  @Binding var content: String
  @Binding var keywords: [String]

  @State private var isPopUpPresented = false

  var body: some View {
    VStack {
      TextField("Title", text: $title)
      KeywordsListView(keywords: $keywords)
      addKeywordButton
      TextEditor(text: $content)
    }
  }

  var addKeywordButton: some View {
    Button("Add Keyword") {
      didTapAddKeywordButton()
    }
    .popover(isPresented: $isPopUpPresented, content: {
      PopUpView(addFunction: addKeyword(_:))
    })
  }

  func didTapAddKeywordButton() {
    isPopUpPresented.toggle()
  }

  func addKeyword(_ word: String) -> Bool{
    guard !keywords.contains(word) else {
      return false
    }

    keywords.append(word)

    return true
  }
}

#Preview {
  @State var title = "New Note"
  @State var content = ""
  @State var keywords: [String] = []

  return NoteFormView(title: $title, content: $content, keywords: $keywords)
}
