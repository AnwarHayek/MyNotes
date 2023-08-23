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

    func firebaseReference(_ collectionReference: FCollectionReference) -> CollectionReference {
        return Firestore.firestore().collection(collectionReference.rawValue)
    }

}
