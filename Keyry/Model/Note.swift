//
//  Note.swift
//  Keyry
//
//  Created by Linda Lau on 2/21/24.
//

import Foundation

class Note: ObservableObject, Identifiable{
  let id = UUID()
  //let dateCreated = Date()
  @Published var keywords: [String] = []
  //@Published var lastEdited = Date()
  @Published var content = ""
  @Published var title: String

  init(_ name: String) {
    self.title = name
  }

  func isKeywordUnique(_ word: String) -> Bool {
    !keywords.contains(word)
  }

  func addKeywords(_ words: [String]) -> Bool{
    let duplicates = Set(keywords).intersection(Set(words))
    guard duplicates.isEmpty else {
      // throw a constructed error with all of the duplicate keywords
      return false
    }

    keywords += words
    return true
  }

  func removeKeywords(_ words: [String]) {
    keywords.removeAll { keyword in
      words.contains(keyword)
    }
  }

//  func addKeyword(_ word: String) -> Bool {
//    guard isKeywordUnique(word) else {
//      return false
//    }
//    keywords.append(word)
//    return true
//  }
}

extension Note: Hashable {
  static func == (lhs: Note, rhs: Note) -> Bool {
    return lhs.content == rhs.content && lhs.title == rhs.title
  }

  func hash(into hasher: inout Hasher) {
    hasher.combine(content)
  }
}
