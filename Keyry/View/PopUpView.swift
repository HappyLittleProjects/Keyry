//
//  PopUpView.swift
//  Keyry
//
//  Created by Linda Lau on 2/28/24.
//

import SwiftUI

struct PopUpView: View {
  @Environment(\.presentationMode) var presentationMode

  var addFunction: (String) -> Bool

  @State private var input: String = ""
  @State private var error = false

  init(addFunction: @escaping (String) -> Bool,
       input: String = "") {
    self.addFunction = addFunction
    _input = State(initialValue: input)
  }

  var body: some View {
    VStack {
      TextField("Name", text: $input)
      if error {
        Text("Already exists.")
      }
      HStack {
        Button("Cancel") {
          didTapCancelButton()
        }
        Button("Add") {
          didTapAddButton()
        }
      }
    }
  }

  func didTapCancelButton() {
    error = false
    presentationMode.wrappedValue.dismiss()
  }

  func didTapAddButton() {
    error = !addFunction(input)
    if !error {
      presentationMode.wrappedValue.dismiss()
    }
  }
}

#Preview {
  var testClosure: (String) -> Bool = { text in
      return false
  }

  var testClosure2: (String) -> Bool = { text in
      return false
  }

  return PopUpView(addFunction: testClosure)//, checkFunction: testClosure2)
}
