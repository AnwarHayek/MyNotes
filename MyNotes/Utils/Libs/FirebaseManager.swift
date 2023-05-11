//
//  FirebaseManager.swift
//  MyNotes
//
//  Created by Anwar Alhayek on 11/05/2023.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseDatabase



class FirebaseManager {

    static let shared = FirebaseManager()

    var ref: DatabaseReference? = Database.database().reference()

    let db = Firestore.firestore()

    let categoriesFiresotreReference: CollectionReference? = Firestore.firestore().collection(CATEGORIES)
    
    let usersDatabaseReference: DatabaseReference? = Database.database().reference().child(USERS)

}

extension DocumentReference {
    func getDocument(handler: @escaping ((_ dic: [String: Any]) -> Void)) {
        self.getDocument { snapshot, error in
            Helper.showLoader(isLoading: false)
            if let error = error {
                FailureResponse.shared.showError(error: error)
                return
            }
            if let dic = snapshot?.data() as? [String: Any] {
                handler(dic)
            }
        }
    }

    func setData(dic: [String: Any], handler: @escaping (() -> Void)) {
        Helper.showLoader(isLoading: true)
        self.setData(dic) { error in
            Helper.showLoader(isLoading: false)

            if let error = error {
                FailureResponse.shared.showError(error: error)
                return
            }
            handler()
        }
    }
}
