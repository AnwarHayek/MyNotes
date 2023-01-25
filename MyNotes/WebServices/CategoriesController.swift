//
//  CategoriesController.swift
//  MyNotes
//
//  Created by Anwar Alhayek on 26/11/2022.
//

import Foundation
import FirebaseDatabase
import MagicalRecord

class CategoriesController {

    var ref: DatabaseReference!

    typealias Handler = (() -> Void)?
    typealias ResultHandler = ((_ categories: [Category], _ showLocalData: Bool) -> Void)?

    init() {
        self.ref = Database.database().reference()
    }

    // MARK: Category data Registration on Realtime Database
    func addCategory(category: Category, result: Handler) {
        let categoryId = UUID().uuidString
        let date = Date.now.dateFormat()
        category.dateCreated = date
        category.uid = categoryId
        if checkInternet() {
            if category.categoryName != "", category.shortDescription != "" {
                Helper.showLoader(isLoading: true)
                ref.child("users").child(UserData.uid ?? "").child("Categories").child(categoryId).setValue(category.getDictionary()) { error, dataBaseReferance in
                    Helper.showLoader(isLoading: false)
                    if let _error = error {
                        FailureResponse.shared.showError(error: _error)
                        return
                    }
                    result?()
                }
                return
            }
            FailureResponse.shared.showError(message: EMPTY_FIELDS_MESSAGE)
        }
    }

    // MARK: Category data Update on Realtime Database
    func updateCategory(category: Category, result: Handler) {
        if checkInternet() {
            if category.categoryName != "", category.shortDescription != "", category.uid != "" {
                Helper.showLoader(isLoading: true)
                ref.child("users").child(UserData.uid ?? "").child("Categories").child(category.uid ?? "").updateChildValues(category.getDictionary()) { error, dataBaseReferance in
                    Helper.showLoader(isLoading: false)
                    if let _error = error {
                        FailureResponse.shared.showError(error: _error)
                        return
                    }
                    result?()
                }
                return
            }
            FailureResponse.shared.showError(message: EMPTY_FIELDS_MESSAGE)
        }
    }

    // MARK: Get All Categories
    func getCategory(result: ResultHandler) {
        var categories: [Category] = []
        var myNotes: [Note] = []
        var waitingNotes: Int = 0
        var doneNotes: Int = 0

        if checkInternet() {
            Helper.showLoader(isLoading: true)
            ref.child("users").child(UserData.uid ?? "").child("Categories").observeSingleEvent(of: .value, with: { (snapshot)in
                Helper.showLoader(isLoading: false)

                for user_child in (snapshot.children) {
                    guard let user_snap = user_child as? DataSnapshot else { return }
                    let dic = user_snap.value as? [String: Any] ?? [:]

                    //All Notes on one  Categories
                    let notesDic = dic["notes"] as? [String: Any] ?? [:]

                    //All notes Key
                    let notesKey = Array(notesDic.keys)

                    for item in notesKey {
                        let note = notesDic[item] as? [String: Any] ?? [:]
                        guard let note = Note.init(uid: item, dictionary: note) else { return }
                        myNotes.append(note)
                        //Calculating the number of done Notes and waiting Notes
                        if note.isDone == true {
                            doneNotes += 1
                        } else {
                            waitingNotes += 1
                        }
                    }
                    myNotes = myNotes.sorted(by: { $0.dateCreated ?? "" > $1.dateCreated ?? "" })
                    myNotes = myNotes.reversed()
                    guard let category = Category.init(uid: user_snap.key, dictionary: dic, notes: myNotes) else { return }
                    categories.append(category)
                    myNotes.removeAll()
                }
                categories = categories.sorted(by: { $0.dateCreated ?? "" > $1.dateCreated ?? "" })
                categories = categories.reversed()
                DataBaseManager.shared.sync(categories: categories)
                //Save Number of categories on UserDefult
                let user = UserData.loadUser()
                user?.categories = categories.count
                user?.waitingNotes = waitingNotes
                user?.doneNotes = doneNotes
                UserData.saveUser(user: user)
                result?(categories, false)
            }
            ) { (error) in
                FailureResponse.shared.showError(error: error)
            }
        } else {
            result?(categories, true)
        }
    }

    // MARK: Delete Categories
    func deleteCategory(category: Category, result: Handler) {
        guard let _categoryUid = category.uid else { return }
        if checkInternet() {
            Helper.showLoader(isLoading: true)
            ref.child("users").child(UserData.uid ?? "").child("Categories").child(_categoryUid).removeValue { error, _ in
                Helper.showLoader(isLoading: true)

                if let _error = error {
                    FailureResponse.shared.showError(error: _error)
                    return
                }
                result?()
            }
        }
    }
}

