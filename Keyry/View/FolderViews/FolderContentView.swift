//
//  FolderContentView.swift
//  Keyry
//
//  Created by Linda Lau on 3/19/24.
//

import SwiftUI

struct FolderContentView: View {
  @ObservedObject var folder: Folder
  @State private var isSearching = false
  @State private var searchTextInput = ""
  @State private var searchResults: [Note] = []

  var body: some View {
    if(folder.subDir.isEmpty && folder.items.isEmpty) {
      Text("Nothing here!")
    }
    else {
      ZStack {
        List {
          folderList
          noteList
        }

        searchLayer
          .padding()
      }
    }
  }

  var folderList: some View {
    ForEach(folder.subDir, id: \.id) { folder in
      NavigationLink(destination: FolderView(folder)){
        FolderCellView(folder: folder)
      }
    }
  }

  var noteList: some View {
    ForEach(folder.items, id: \.id) { note in
      ZStack(alignment: .leading){
        NavigationLink(destination: NoteView(folder: folder, note: note)){
          HStack {}
        }.opacity(0)

        NoteCellView(note: note)
      }
    }
  }

  var searchLayer: some View {
    VStack {
      Spacer()
      HStack {
        Spacer()
        searchButton
      }
    }
  }

  var searchButton: some View {
    Button {
      isSearching.toggle()
    } label: {
      Image(systemName: "magnifyingglass")
    }
    .sheet(isPresented: $isSearching) {
      SearchView(
        folder: folder,
        searchTextInput: $searchTextInput,
        searchResults: $searchResults
      )
    }
  }
}

struct FolderCellView: View {

  @ObservedObject var folder: Folder

  var body: some View {
    HStack {
      Image(systemName: "folder")
        .frame(width: 25, height: 25)
      Text(folder.name)
    }
  }

}

struct NoteCellView: View {

  @ObservedObject var note: Note

  var body: some View {
    HStack {
      Image(systemName: "doc")
        .frame(width: 25, height: 25)
      Text(note.title)
    }
  }
}

#Preview {
  let folder = Folder("New Folder")
  return FolderContentView(folder: folder)
}
