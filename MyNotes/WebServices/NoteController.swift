//
//  NoteController.swift
//  MyNotes
//
//  Created by Anwar Alhayek on 08/12/2022.
//

import Foundation
import FirebaseDatabase

class NoteController {

    var ref: DatabaseReference!

    typealias Handler = (() -> Void)?
    typealias ResultHandler = ((_ notes: [Note]) -> Void)?

    init() {
        self.ref = Database.database().reference()
    }

    // MARK: Note data Registration on Realtime Database
    func addNote(note: Note, category: Category, result: Handler) {
        let noteId = UUID().uuidString
        let date = Date.now.dateFormat()
        note.dateCreated = date
        note.uid = noteId
        if checkInternet() == true {
            Helper.showLoader(isLoading: true)
            ref.child("users").child(UserData.uid ?? "").child("Categories").child(category.uid ?? "").child("notes").child(noteId).setValue(note.getDictionary()) { error, _ in
                Helper.showLoader(isLoading: false)
                if let _error = error {
                    FailureResponse.shared.showError(error: _error)
                    return
                }
                result?()
            }
            return
        }
    }

    // MARK: Note deata Update on Realtime Database
    func updateNote(note: Note, category: Category, result: Handler) {
        guard let _noteUid = note.uid, let _categoryUid = category.uid else { return }
        if checkInternet() {
            Helper.showLoader(isLoading: true)
            ref.child("users").child(UserData.uid ?? "").child("Categories").child(_categoryUid).child("notes").child(_noteUid).updateChildValues(note.getDictionary()) { error, dataBaseReferance in
                Helper.showLoader(isLoading: false)
                if let _error = error {
                    FailureResponse.shared.showError(error: _error)
                    return
                }
                result?()
            }
            return
        }
    }

    // MARK: Delete Note
    func deleteNote(note: Note, category: Category, result: Handler) {
        guard let _categoryUid = category.uid, let _noteUid = note.uid else { return }
        if checkInternet() {
            ref.child("users").child(UserData.uid ?? "").child("Categories").child(_categoryUid).child("notes").child(_noteUid).removeValue { error, _ in
                if let _error = error {
                    FailureResponse.shared.showError(error: _error)
                    return
                }
                result?()
            }
        }
    }

    func isDone(note: Note, category: Category) {
        guard let _categoryUid = category.uid, let _noteUid = note.uid, let _bool = note.isDone else { return }
        if checkInternet() {
            ref.child("users").child(UserData.uid ?? "").child("Categories").child(_categoryUid).child("notes").child(_noteUid).updateChildValues(["isDone": _bool]) { error, _ in
                Helper.showLoader(isLoading: false)

                if let _error = error {
                    FailureResponse.shared.showError(error: _error)
                    return
                }
            }
        }
    }
}

