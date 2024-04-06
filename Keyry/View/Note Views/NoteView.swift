//
//  NoteView.swift
//  Keyry
//
//  Created by Linda Lau on 3/6/24.
//

import SwiftUI

struct NoteView: View {
  @ObservedObject var folder: Folder
  @ObservedObject var note: Note

  @State var isEditing = false
  @State var newTitleTextField = ""

  init(folder: Folder, note: Note) {
    print("NoteView init called")

    self.folder = folder
    self.note = note

    _newTitleTextField = State(initialValue: note.title)
  }

  var body: some View {
    NavigationView {
      VStack {
        ScrollView {
          ForEach(note.keywords, id: \.self) { keyword in
            Text(keyword)
          }
          Text(note.content)
        }
      }
    }
    .navigationTitle(note.title)
    .toolbar {
      ToolbarItem(placement: .topBarTrailing) {
        editNoteButton
      }
    }
  }

  var editNoteButton: some View {
    NavigationLink {
      EditNoteView(note: note, folder.nameExists(_:))
    } label: {
      Image(systemName: "pencil")
    }
  }

  func didTapEditButton() {
    newTitleTextField = note.title
    isEditing.toggle()
  }

  func didTapCancelButton() {
    isEditing.toggle()
  }

  func didTapSaveButton() {
    note.title = newTitleTextField
    isEditing.toggle()
  }
}

#Preview {
  let folder = Folder()
  let note = Note("Some Note")

  return NoteView(folder: folder, note: note)
}
