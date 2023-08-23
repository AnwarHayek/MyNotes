//
//  User.swift
//  MyNotes
//
//  Created by Anwar Alhayek on 24/11/2022.
//

import Foundation

class User: Codable {

    var uid: String?
    var firsName: String?
    var lastName: String?
    var email: String?
    var phone: String?
    var password: String?
    var categories: Int?
    var doneNotes: Int?
    var waitingNotes: Int?

    init(uid: String? = nil, firsName: String? = nil, lastName: String? = nil, email: String? = nil, phone: String? = nil, password: String? = nil, categories: Int? = nil, doneNotes: Int? = nil, waitingNotes: Int? = nil) {
        self.uid = uid
        self.firsName = firsName
        self.lastName = lastName
        self.email = email
        self.phone = phone
        self.password = password
        self.categories = categories
        self.doneNotes = doneNotes
        self.waitingNotes = waitingNotes
    }

    init?(uid: String, dictionary: [String: Any]?) {
        guard let _dictionary = dictionary else { return nil }

        self.firsName = _dictionary["firsName"] as? String
        self.lastName = _dictionary["lastName"] as? String
        self.email = _dictionary["email"] as? String
        self.phone = _dictionary["phone"] as? String
        self.categories = _dictionary["categories"] as? Int
        self.doneNotes = _dictionary["doneNotes"] as? Int
        self.waitingNotes = _dictionary["waitingNotes"] as? Int
        self.password = _dictionary["password"] as? String
        self.uid = uid
    }

    func getDictionary() -> [String: Any] {
        let dictionary: [String: Any?] = [
            "firsName": self.firsName ?? "",
            "lastName": self.lastName ?? "",
            "email": self.email ?? "",
            "phone": self.phone ?? "",
            "categories": self.categories ?? 0,
            "doneNotes": self.doneNotes,
            "waitingNotes": self.waitingNotes
        ]
        return dictionary as [String: Any]
    }

}
