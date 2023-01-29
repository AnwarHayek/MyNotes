//
//  UserController.swift
//  MyNotes
//
//  Created by Anwar Alhayek on 24/11/2022.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import MagicalRecord

class UserController {

    static let shared = UserController()

    private let db = Firestore.firestore()
    private var usersFireStoreReference: CollectionReference?

    typealias Handler = (() -> Void)?
    typealias ResultHandler = ((_ user: User?) -> Void)?
    typealias FailureHandler = ((_ errorMessage: String?) -> Void)?

    init() {
        self.usersFireStoreReference = db.collection(USERS)
    }

    // MARK: SignUp By Email
    func signUp(user: User, result: Handler) {
        guard let _email = user.email, let _password = user.password else { return }

        Helper.showLoader(isLoading: true)
        Auth.auth().createUser(withEmail: _email, password: _password) { userResult, error in

            if let _error = error {
                Helper.showLoader(isLoading: false)
                FailureResponse.shared.showError(error: _error)
                return
            }
            user.uid = userResult?.user.uid
            self.setUser(user: user)
            UserData.saveUser(user: user)
            result?()
        }
        return
    }

    // MARK: User data Registration on Firestore
    func setUser(user: User) {
        guard let _usersFireStoreReference = self.usersFireStoreReference, let _uid = user.uid else { return }

        _usersFireStoreReference.document(_uid).setData(user.toDictionary()) { error in
            Helper.showLoader(isLoading: false)

            if let _error = error {
                FailureResponse.shared.showError(error: _error)
                return
            }
        }
    }

    // MARK: Sign In By Email
    func signInByEmail(user: User, result: Handler) {
        guard let _email = user.email, let _password = user.password else { return }
        Helper.showLoader(isLoading: true)

        Auth.auth().signIn(withEmail: _email, password: _password) { userResult, error in
            if let _error = error {
                Helper.showLoader(isLoading: false)
                FailureResponse.shared.showError(error: _error)
                return
            }
            let uid = userResult?.user.uid

            self.getUserData(uid: uid) { user in
                if let _user = user {
                    _user.password = _password
                    UserData.saveUser(user: _user)
                    result?()
                    return
                }
                FailureResponse.shared.showError(message: SERVER_ERROR_MESSAGE)
            }
        }
    }

    // MARK: Get User Data From Firestore
    func getUserData(uid: String?, result: ResultHandler) {
        guard let _usersFireStoreReference = self.usersFireStoreReference, let _uid = uid else { return }
        _usersFireStoreReference.document(_uid).getDocument { userResult, error in

            if let _error = error {
                FailureResponse.shared.showError(error: _error)
                Helper.showLoader(isLoading: false)
                return
            }

            let user = User.init(uid: _uid, dictionary: userResult?.data())
            Helper.showLoader(isLoading: false)
            result?(user)
        }
    }

    // MARK: signOut
    func signOut(handler: Handler) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            UserData.clearUserDefaults()
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
        guard let auth = UserData.loadUser(), let _email = auth.email, let _password = auth.password else { return }
        let credential = EmailAuthProvider.credential(withEmail: _email, password: _password)

        Auth.auth().currentUser?.reauthenticate(with: credential, completion: { auth, error in
            if let _error = error {
                Helper.showLoader(isLoading: false)
                FailureResponse.shared.showError(error: _error)
                return
            }
            result?()
        })
    }

    // MARK: Change Password
    func changePassword(password: String?, result: Handler) {
        guard let _password = password else { return }
        Helper.showLoader(isLoading: true)
        self.reauthenticate {

            Auth.auth().currentUser?.updatePassword(to: _password) { (error) in
                Helper.showLoader(isLoading: false)
                if let _error = error {
                    FailureResponse.shared.showError(error: _error)
                    return
                }
                //Edit Password in User Default
                let user = UserData.loadUser()
                user?.password = _password
                UserData.saveUser(user: user)
                result?()
            }
        }
    }

    // MARK: Edit User Data
    func updateUserData(user: User?, handler: Handler) {
        guard let _user = user, let _uid = UserData.uid, let _firstName = _user.firsName, let _lastName = _user.lastName, let _phone = _user.phone else { return }

        Helper.showLoader(isLoading: true)
        self.reauthenticate {
            self.usersFireStoreReference?.document(_uid).updateData([
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


