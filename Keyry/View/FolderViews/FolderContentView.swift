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
      ZStack(alignment: .trailing) {
        List {
          folderList
          noteList
        }

        searchButton
          .frame(maxHeight: .infinity, alignment: .bottom)
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
    .onDelete(perform: { indexSet in
      folder.subDir.remove(atOffsets: indexSet)
    })
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
    .onDelete(perform: { indexSet in
      folder.items.remove(atOffsets: indexSet)
    })
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

#Preview {
  let folder = Folder("New Folder")
  return FolderContentView(folder: folder)
}
