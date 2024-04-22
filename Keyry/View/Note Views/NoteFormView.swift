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
    Form {
      VStack(alignment: .leading) {
        Text("Title:")
          .font(.caption2)
        TextField("Title", text: $title)
      }

      VStack(alignment: .leading) {
        KeywordsExpandableView(keywords: keywords, isExpandable: false)
        addKeywordButton
      }

      TextField("", text: $content, axis: .vertical)
    }
  }

  var addKeywordButton: some View {
    Button {
      didTapAddKeywordButton()
    } label: {
      Image(systemName: "plus.circle")
        .padding(3)
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
      print("Error adding keyword: Keyword already exists.")
      return false
    }
    
    keywords.append(word)
    print("Keyword Added: \(word)")
    print("Keyword array:")
    for keyword in keywords {
      print(keyword)
    }

    return true
  }
}

#Preview {
  @State var title = "New Note"
  @State var content = "asfasfasf asdf"
  @State var keywords: [String] = [
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

  return NoteFormView(title: $title, content: $content, keywords: $keywords)

//  return NoteFormView(titleText: $title, keywordsList: $keywords, contentText: $content)
}
