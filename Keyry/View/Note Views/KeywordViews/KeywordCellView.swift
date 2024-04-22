//
//  KeywordCellView.swift
//  Keyry
//
//  Created by Linda Lau on 4/9/24.
//

import SwiftUI

struct KeywordCellView: View {

  let label: String
  let editMode: Bool

  var body: some View {
    HStack (spacing: 5){
      Text(label)
        .font(.caption)
      if editMode {
        Image(systemName: "xmark")
      }
    }
    .padding(.leading, 15)
    .padding(.trailing, editMode ? 8 : 15)
    .padding([.top, .bottom], 5)
    .foregroundColor(.white)
    .background(Color.accentColor)
    .clipShape(Capsule())
  }
}

#Preview {
  return KeywordCellView(label: "Hello World", editMode: true)
}
