//
//  CreateNoteView.swift
//  Keyry
//
//  Created by Linda Lau on 3/18/24.
//

import SwiftUI

struct CreateNoteView: View {
  @Environment(\.presentationMode) var presentationMode

  var addNote: (Note) -> Bool

  @State var titleTextField: String
  @State private var contentTextField = ""
  @State private var keywordsList: [String] = []
  @State private var hasError = false

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
    .navigationTitle("Create New Note")
    .toolbar {
      ToolbarItem(placement: .topBarLeading) {
        cancelButton
      }
      ToolbarItem(placement: .topBarTrailing) {
        addButton
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

  var addButton: some View {
    Button {
      let note = Note(titleTextField)
      note.content = contentTextField
      note.keywords = keywordsList
      if !addNote(note) {
        hasError.toggle()
      }
      else {
        presentationMode.wrappedValue.dismiss()
      }
    } label: {
      Text("Save")
    }
  }
}

#Preview {
  var someFunc: (Note) -> Bool = { note in
    return true
  }
  @State var someString = "New Note"

  return CreateNoteView(addNote: someFunc, titleTextField: someString)
}
