//
//  UserData.swift
//  MyNotes
//
//  Created by Anwar Alhayek on 25/11/2022.
//

import Foundation

class UserData {

    static func saveUser(user: User?) {
        guard let user = user else { return }
        let data = try? JSONSerialization.data(withJSONObject: user.toDictionary(), options: .fragmentsAllowed)
        UserDefaults.standard.setValue(data, forKey: USER_KEY)
        UserDefaults.standard.set(user.uid, forKey: ID_KEY)
        UserDefaults.standard.synchronize()
    }

    static func loadUser() -> User? {
        let uid = UserDefaults.standard.string(forKey: ID_KEY)
        let data = UserDefaults.standard.value(forKey: USER_KEY) as? Data
        if let _data = data, let _uid = uid {
            if let dictionary = try? JSONSerialization.jsonObject(with: _data, options: .fragmentsAllowed) as? [String: Any?] {
                return User.init(uid: _uid, dictionary: dictionary as [String: Any])
            }
        }
        return nil
    }

    static func clearUserDefaults() {
        if let appDomain = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: appDomain)
        }
    }

    static func deleteUserData() {
        UserDefaults.standard.removeObject(forKey: USER_KEY)
    }

    static var uid: String? {
        set {
            loadUser()?.uid = newValue
        } get {
            return loadUser()?.uid ?? ""
        }
    }

    static var email: String {
        set {
            loadUser()?.email = newValue
        } get {
            return loadUser()?.email ?? ""
        }
    }

    static var firstName: String {
        set {
            loadUser()?.firsName = newValue
        } get {
            return loadUser()?.firsName ?? ""
        }
    }

    static var lastName: String {
        set {
            loadUser()?.lastName = newValue
        } get {
            return loadUser()?.lastName ?? ""
        }
    }

    static var phone: String {
        set {
            loadUser()?.phone = newValue
        } get {
            return loadUser()?.phone ?? ""
        }
    }

    static var password: String {
        set {
            loadUser()?.password = newValue
        } get {
            return loadUser()?.password ?? ""
        }
    }

    static var categories: Int {
        set {
            loadUser()?.categories = newValue
        } get {
            return loadUser()?.categories ?? 0
        }
    }

    static var waitingNotes: Int {
        set {
            loadUser()?.waitingNotes = newValue
        } get {
            return loadUser()?.waitingNotes ?? 0
        }
    }

    static var doneNotes: Int {
        set {
            loadUser()?.doneNotes = newValue
        } get {
            return loadUser()?.doneNotes ?? 0
        }
    }
}

