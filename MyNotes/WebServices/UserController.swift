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
        if let _email = user.email, let _password = user.password, user.firsName != "", user.lastName != "", user.phone != "" {

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
        FailureResponse.shared.showError(error: EMPTY_FIELDS_ERROR)
    }

    // MARK: User data Registration on Firestore
    func setUser(user: User) {
        guard let _usersFireStoreReference = self.usersFireStoreReference, let _uid = user.uid else { return }

        _usersFireStoreReference.document(_uid).setData(user.getDictionary()) { error in
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
                    UserData.saveUser(user: _user)
                    result?()
                    return
                }
                let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: SERVER_ERROR_MESSAGE])
                FailureResponse.shared.showError(error: error)
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

    func signOut(failure: FailureHandler) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            UserData.clearUserDefaults()
            TNote.mr_truncateAll()
            TCategories.mr_truncateAll()
            failure?(nil)
        } catch let error as NSError {
            FailureResponse.shared.showError(error: error)
        }
    }
}
