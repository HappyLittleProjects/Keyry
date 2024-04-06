//
//  EditNoteView.swift
//  Keyry
//
//  Created by Linda Lau on 4/4/24.
//

import SwiftUI

struct EditNoteView: View {
  @Environment(\.presentationMode) var presentationMode

  @ObservedObject var note: Note

  private var titleCheckFunction: (String) -> Bool

  @State private var titleTextField: String
  @State private var contentTextField: String
  @State private var keywordsList: [String]
//  @State private var addKeywordsList: [String] = []
//  @State private var removeKeywordsList: [String] = []
  @State private var hasError = false

  init(note: Note, _ titleCheckFunction: @escaping (String) -> Bool) {
    _titleTextField = State(initialValue: note.title)
    _contentTextField = State(initialValue: note.content)
    _keywordsList = State(initialValue: note.keywords)
    self.note = note
    self.titleCheckFunction = titleCheckFunction
  }

  var body: some View {
    NavigationView {
      VStack {
        if hasError {
          Text("Title already exists.")
        }

        NoteFormView(
          title: $titleTextField,
          content: $contentTextField,
          keywords: $keywordsList
        )
      }
    }
    .navigationBarBackButtonHidden(true)
    .navigationTitle("Edit Note")
    .toolbar {
      ToolbarItem(placement: .topBarLeading) {
        cancelButton
      }
      ToolbarItem(placement: .topBarTrailing) {
        saveButton
      }
    }
  }

  var cancelButton: some View {
    Button {
      presentationMode.wrappedValue.dismiss()
    } label: {
      HStack {
        Image(systemName: "chevron.left")
        Text("Cancel")
      }
    }
  }

  var saveButton: some View {
    Button {
      didTapSaveButton()
    } label: {
      Text("Save")
    }
  }

  func didTapSaveButton() {
    guard !(titleCheckFunction(titleTextField) && titleTextField != note.title)
    else {
      print("current title: \(note.title)")
      print("new title: \(titleTextField)")
      hasError = true
      return
    }

    note.title = titleTextField
    note.content = contentTextField
    note.keywords = keywordsList

    presentationMode.wrappedValue.dismiss()
  }
}

//#Preview {
//    EditNoteView()
//}
