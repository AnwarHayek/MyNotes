//
//  Category.swift
//  MyNotes
//
//  Created by Anwar Alhayek on 26/11/2022.
//

import Foundation

class Category {

    var categoryName: String?
    var shortDescription: String?
    var uid: String?
    var dateCreated: String?
    var notes: [Note]?

    init(categoryName: String? = nil, shortDescription: String? = nil, note: [Note]? = nil, uid: String? = nil, dateCreated: String? = nil) {
        self.categoryName = categoryName
        self.shortDescription = shortDescription
        self.notes = note
        self.uid = uid
        self.dateCreated = dateCreated
    }

    func getDictionary() -> [String: Any] {
        let dictionary: [String: Any?] = [
            "categoryName": self.categoryName ?? "",
            "shortDescription": self.shortDescription ?? "",
            "dateCreated": self.dateCreated ?? ""
        ]
        return dictionary as [String: Any]
    }

    init?(uid: String?, dictionary: [String: Any]?, notes: [Note]?) {
        guard let _dictionary = dictionary else { return nil }
        self.categoryName = _dictionary["categoryName"] as? String
        self.shortDescription = _dictionary["shortDescription"] as? String
        self.dateCreated = _dictionary["dateCreated"] as? String
        self.uid = uid
        self.notes = notes
    }

    init?(category: TCategories) {
        self.categoryName = category.title
        self.shortDescription = category.categorie_description
        self.uid = category.uid
        self.dateCreated = category.dateCreated
    }
}

