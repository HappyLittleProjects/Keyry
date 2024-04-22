//
//  NoteCellView.swift
//  Keyry
//
//  Created by Linda Lau on 4/5/24.
//

import SwiftUI

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
  let note = Note("Test")
  return NoteCellView(note: note)
}
