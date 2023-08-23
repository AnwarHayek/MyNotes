//
//  AuthController.swift
//  MyNotes
//
//  Created by Anwar Alhayek on 23/08/2023.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import MagicalRecord
import Firebase

class AuthController {

    typealias Handler = (() -> Void)?
    typealias ResultHandler = ((_ user: User?) -> Void)?
    typealias FailureHandler = ((_ errorMessage: String?) -> Void)?

    private let usersReference = FirebaseManager.shared.firebaseReference(.User)

    // MARK: SignUp By Email
    func registerWithEmail(user: User, completion: ResultHandler) {
        guard let email = user.email, let password = user.password else { return }
        Auth.auth().createUser(withEmail: email, password: password) { (authDataResult, error) in
            guard FailureResponsee.shared.showError(error: error) else { completion?(nil); return }
            user.uid = authDataResult?.user.uid
            self.saveUserToFirestore(user: user) { user in
                completion?(user)
            }
        }
    }

    // MARK: User data Registration on Firestore
    private func saveUserToFirestore(user: User?, completion: ResultHandler) {
        guard let user = user, let uid = user.uid else { return }
        self.usersReference.document(uid).setData(user.getDictionary()) { error in
            guard FailureResponsee.shared.showError(error: error) else { completion?(nil); return }
            UserData.saveUser(user: user)
            completion?(user)
        }
    }

    // MARK: Sign In By Email
    func loginWithEmail(email: String?, password: String?, completion: ResultHandler) {
        guard let email = email, let password = password else { return }
        Auth.auth().signIn(withEmail: email, password: password) { (authDataResult, error) in
            guard FailureResponsee.shared.showError(error: error) else { completion?(nil); return }
            self.dowlandUserFromFirebase(uid: authDataResult?.user.uid, password: password) { user in
                completion?(user)
            }
        }
    }

    // MARK: Get User Data From Firestore
    private func dowlandUserFromFirebase(uid: String?, password: String, completion: ResultHandler) {
        guard let uid = uid else { return }
        self.usersReference.document(uid).getDocument { snapshot, error in
            guard FailureResponsee.shared.showError(error: error) else { completion?(nil); return }
            if let userDic = snapshot?.data() as? [String: Any] {
                guard let user = User.init(uid: uid, dictionary: userDic) else { return }
                user.password = password
                UserData.saveUser(user: user)
                completion?(user)
            }
        }
    }

    // MARK: Get User Data From Firestore
    func getUserData(uid: String?, result: ResultHandler) {
        guard let _uid = uid else { return }
        self.usersReference.document(_uid).getDocument { dic in
            let user = User.init(uid: _uid, dictionary: dic)
            Helper.showLoader(isLoading: false)
            result?(user)
        }
    }

    // MARK: signOut
    func signOut(handler: Handler) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            UserData.deleteUserData()
            TNote.mr_truncateAll()
            TCategories.mr_truncateAll()
            NSManagedObjectContext.mr_default().mr_saveToPersistentStoreAndWait()
            handler?()
        } catch let error as NSError {
            FailureResponse.shared.showError(error: error)
        }
    }
    
    
    // MARK: Reauthenticate
    func reauthenticate(result: Handler) {
        guard let user = UserData.loadUser(), let email = user.email, let password = user.password else { return }
        let credential = EmailAuthProvider.credential(withEmail: email, password: password)
        Auth.auth().currentUser?.reauthenticate(with: credential, completion: { auth, error in
            guard FailureResponsee.shared.showError(error: error) else { return }
            result?()
        })
    }

    // MARK: Change Password
    func changePassword(password: String?, result: Handler) {
        guard let password = password else { return }
        guard checkInternet(showAlert: true) else { return }
        Helper.showLoader()
        self.reauthenticate {
            Auth.auth().currentUser?.updatePassword(to: password) { (error) in
                Helper.showLoader(isLoading: false)
                guard FailureResponsee.shared.showError(error: error) else { return }

                //Edit Password in User Default
                let user = UserData.loadUser()
                user?.password = password
                UserData.saveUser(user: user)
                result?()
            }
        }
    }

// MARK: Edit User Data
    func updateUserData(user: User?, handler: Handler) {
        guard let _user = user, let _firstName = _user.firsName, let _lastName = _user.lastName, let _phone = _user.phone else { return }
        guard checkInternet(showAlert: true) else { return }
        Helper.showLoader(isLoading: true)
        self.reauthenticate {
            self.usersReference.document(UserData.uid).updateData([
                "firsName": _firstName,
                "lastName": _lastName,
                "phone": _phone
            ]) { error in
                Helper.showLoader(isLoading: false)
                if let _error = error {
                    FailureResponse.shared.showError(error: _error)
                    return
                }
                //Edit name in User Default
                let user = UserData.loadUser()
                user?.firsName = _firstName
                user?.lastName = _lastName
                user?.phone = _phone
                UserData.saveUser(user: user)
                handler?()
            }
        }
    }
}



