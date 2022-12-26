//
//  Note.swift
//  MyNotes
//
//  Created by Anwar Alhayek on 26/11/2022.
//

import Foundation

class Note {

    var title: String?
    var description: String?
    var isDone: Bool?
    var uid: String?
    var dateCreated: String?

    init(title: String? = nil, description: String? = nil, isDone: String? = nil, uid: String? = nil, dateCreated: String? = nil) {
        self.title = title
        self.description = description
        self.uid = uid
        self.dateCreated = dateCreated
        if isDone == "false" {
            self.isDone = false
        } else {
            self.isDone = true
        }
    }

    func getDictionary() -> [String: Any] {
        let dictionary: [String: Any?] = [
            "title": self.title ?? "",
            "description": self.description ?? "",
            "isDone": self.isDone ?? "false",
            "dateCreated": self.dateCreated ?? ""
        ]
        return dictionary as [String: Any]
    }

    init?(uid: String?, dictionary: [String: Any]?) {
        guard let _dictionary = dictionary else { return nil }

        self.title = _dictionary["title"] as? String
        self.description = _dictionary["description"] as? String
        self.isDone = _dictionary["isDone"] as? Bool
        self.dateCreated = _dictionary["dateCreated"] as? String
        self.uid = uid
    }

    init?(note: TNote) {
        self.title = note.title
        self.description = note.note_description
        self.uid = note.uid
        self.dateCreated = note.dateCreated
        self.isDone = note.isDone
    }
}
