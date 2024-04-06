//
//  FolderView.swift
//  Keyry
//
//  Created by Linda Lau on 2/21/24.
//

import SwiftUI

struct FolderView: View {
  @ObservedObject var folder: Folder
  @State private var hasNewFolderPopOver = false
  @State private var userTextInput = ""

  init(_ folder: Folder = Folder("root")) {
    self.folder = folder
  }

  var body: some View {
    NavigationStack {
      FolderContentView(folder: folder)
      .navigationTitle(folder.name)
      .toolbar {
        // button to open popover to create new folder
        ToolbarItem(placement: .topBarTrailing) {
          createFolderButton
        }

        // navigation button to create new note
        ToolbarItem(placement: .topBarTrailing) {
          createNoteButton
        }
      }
    }
  }

  var createFolderButton: some View {
    Button {
      didTapCreateFolder()
    } label: {
      Image(systemName: "folder.badge.plus")
    }
    .popover(isPresented: $hasNewFolderPopOver, arrowEdge: .top) {
      // addFunction: (String) -> Bool

      VStack {
        Text("Create Folder")
        PopUpView(
          addFunction: addFolder(name:),
          input: folder.makeUniqueName("New Folder")
        )
      }
    }
  }

  var createNoteButton: some View {
    NavigationLink(
      destination: 
        CreateNoteView(
          addNote: folder.addNote(_:),
          titleTextField: folder.makeUniqueName("New Note")
        )
    ) {
      Image(systemName: "doc.badge.plus")
    }
  }

  func addFolder(name: String) -> Bool {
    let success = folder.newFolder(name)
    return success != nil
  }

  func didTapCreateFolder() {
    hasNewFolderPopOver = true
    userTextInput = folder.makeUniqueName("New Folder")
  }
}

#Preview {
  let folder = Folder("Test Folder")
  let testNote = Note("Test Note 1")
  let _ = testNote.addKeywords(["abc", "ABC", "Abc"])
  _ = folder.addNote(testNote)
  _ = folder.newFolder("Test Folder 1")

  return FolderView(folder)
}
