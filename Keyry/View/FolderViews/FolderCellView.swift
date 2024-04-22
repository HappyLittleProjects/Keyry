//
//  FolderCellView.swift
//  Keyry
//
//  Created by Linda Lau on 4/5/24.
//

import SwiftUI

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

#Preview {
  let folder = Folder()
  return FolderCellView(folder: folder)
}
