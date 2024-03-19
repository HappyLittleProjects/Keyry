//
//  Folder.swift
//  Keyry
//
//  Created by Linda Lau on 2/21/24.
//

import Foundation
import SwiftUI

//struct CurrentDirectoryKey: EnvironmentKey {
//    static let defaultValue: Folder = Folder("root")
//}
//
//extension EnvironmentValues {
//    var currentDirectory: Folder {
//        get { self[CurrentDirectoryKey.self] }
//        set { self[CurrentDirectoryKey.self] = newValue }
//    }
//}

class Folder: ObservableObject{
    @Published var subDir: [Folder] = []
    @Published var items: [Note] = []
    @Published var name: String
    
    init(_ name: String = "New Folder") {
        self.name = name
    }
    
    // check for items/folders with duplicate names
    func nameExists(_ name: String) -> Bool {
        subDir.contains(where: { $0.name == name }) 
        || items.contains(where: { $0.title == name })
    }
    
    // add a suffix to items/folders with duplicate names to make names unique
    func makeUniqueName(_ name: String) -> String {
        var newName = name
        var count = 1
        while nameExists(newName) {
            newName = "\(name) (\(count))"
            count += 1
        }
        
        return newName
    }
    
    // create new empty folder if parameter `name` is unique and not an empty 
    // string
    func newFolder(_ name: String) -> Folder? {
        if !nameExists(name) && name.count > 0 {
            let folder = Folder(name)
            subDir.append(folder)
            return folder
        }
        return nil
    }
    
    // add a note to folder if the title of the note is unique
    func addNote(_ note: Note) -> Bool{
        guard !nameExists(note.title) else {
            return false
        }
        items.append(note)
        print("New Note created: \(note.title)")
        
        return true
    }
    
    // search notes in current folder and sub folders for notes that contain a 
    // keyword or name that matches input
    func search(_ keyword: String) -> [Note]? {
        
        return nil
    }
}

extension Folder: Hashable {
    static func == (lhs: Folder, rhs: Folder) -> Bool {
        return lhs.name == rhs.name &&
               lhs.subDir == rhs.subDir &&
               lhs.items == rhs.items
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(subDir)
        hasher.combine(items)
    }
}
