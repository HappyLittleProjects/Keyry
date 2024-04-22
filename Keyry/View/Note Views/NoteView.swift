//
//  NoteView.swift
//  Keyry
//
//  Created by Linda Lau on 3/6/24.
//

import SwiftUI

struct NoteView: View {
  @Environment(\.editMode) private var editMode

  @ObservedObject var folder: Folder
  @ObservedObject var note: Note

  @State var keywordsList: [String]

  @State var isEditing = false
  @State var newTitleTextField = ""

  init(folder: Folder, note: Note) {
    print("NoteView init called")

    self.folder = folder
    self.note = note

    _keywordsList = State(initialValue: note.keywords)

    _newTitleTextField = State(initialValue: note.title)
  }

  var body: some View {
    NavigationView {
      ScrollView {
        VStack (spacing: 10){
          KeywordsExpandableView(keywords: keywordsList, isExpandable: true)
            .padding(.bottom, 25)

          Text(note.content)
        }
      }
      .padding()
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
  let _ = note.addKeywords(["test 1", "test 2", "test 3", "test 4", "test 5", "test 6", "test 789", "test 10", "test 11", "test 12", "test 13", "test 14", "test 15", "test 16", "test 17",])
  note.content = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890"

  return NoteView(folder: folder, note: note)
}
