//
//  FolderContentView.swift
//  Keyry
//
//  Created by Linda Lau on 3/19/24.
//

import SwiftUI

struct FolderContentView: View {
  @ObservedObject var folder: Folder

  var body: some View {
    if(folder.subDir.isEmpty && folder.items.isEmpty) {
      Text("Nothing here!")
    }
    else {
      List {
        folderList
        noteList
      }
    }
  }

  var folderList: some View {
    ForEach(folder.subDir, id: \.id) { folder in
      NavigationLink(destination: FolderView(folder)){
        Text(folder.name)
      }
    }
  }

  var noteList: some View {
    ForEach(folder.items, id: \.id) { note in
      NavigationLink(destination: NoteView(folder: folder, note: note)){
        Text(note.title)
      }
    }
  }
}

#Preview {
  let folder = Folder("New Folder")
  return FolderContentView(folder: folder)
}
