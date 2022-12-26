//
//  DataBaseManager.swift
//  MyNotes
//
//  Created by Anwar Alhayek on 22/11/2022.
//

import Foundation
import MagicalRecord

class DataBaseManager {

    static let shared = DataBaseManager()

    func sync(categories: [Category]) {

        for item in categories {
            let category: TCategories? = TCategories.mr_findFirstOrCreate(byAttribute: "uid", withValue: item.uid ?? "")

            category?.uid = item.uid
            category?.title = item.categoryName
            category?.categorie_description = item.shortDescription
            category?.dateCreated = item.dateCreated
            var notes: [TNote] = []

            if let _notes = item.notes {
                
                for item in _notes {
                    let note: TNote? = TNote.mr_findFirstOrCreate(byAttribute: "uid", withValue: item.uid ?? "")
                    
                    note?.uid = item.uid
                    note?.title = item.title
                    note?.isDone = item.isDone ?? false
                    note?.note_description = item.description

                    if let note = note {
                        category?.notes?.adding(note)
                        notes.append(note)
                    }


                }
                if notes.count > 0 {
                    category?.notes = NSSet.init(array: notes)
                }
            }
            NSManagedObjectContext.mr_default().mr_saveToPersistentStoreAndWait()
        }
    }
}

