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

        searchButton
          .padding()
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

  var searchButton: some View {
    VStack {
      Spacer()
      HStack {
        Spacer()
        Button {
          isSearching.toggle()
        } label: {
          Image(systemName: "magnifyingglass")
        }
        .sheet(isPresented: $isSearching) {
          NavigationView {
            VStack {
              TextField("search", text: $searchTextInput)
                .onChange(of: searchTextInput) {
                  searchResults = folder.search(searchTextInput)
                }
              List {
                if searchResults.isEmpty {
                  Text("No Results")
                }
                ForEach(searchResults, id: \.self) { note in
                  NavigationLink(destination: NoteView(folder: folder, note: note)) {
                    Text(note.title)
                  }
                }
              }
            }
          }
        }
      }
    }
  }
}

#Preview {
  let folder = Folder("New Folder")
  return FolderContentView(folder: folder)
}
