//
//  UserData.swift
//  MyNotes
//
//  Created by Anwar Alhayek on 25/11/2022.
//

import Foundation

class UserData {

    // Save the encoded data to UserDefaults
    static func saveUser(user: User?) {
        guard let user = user else { return }
        let encoder = JSONEncoder()
        if let encodedData = try? encoder.encode(user) {
            UserDefaults.standard.set(encodedData, forKey: USER_KEY)
        }
    }

    // Decode the data into a User object
    static func loadUser() -> User? {
        if let savedData = UserDefaults.standard.data(forKey: USER_KEY) {
            let decoder = JSONDecoder()
            if let savedPerson = try? decoder.decode(User.self, from: savedData) {
                return savedPerson
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

    static var uid: String {
        get {
            return loadUser()?.uid ?? ""
        }
    }

    static var email: String {
        get {
            return loadUser()?.email ?? ""
        }
    }

    static var firstName: String {
        get {
            return loadUser()?.firsName ?? ""
        }
    }

    static var lastName: String {
        get {
            return loadUser()?.lastName ?? ""
        }
    }

    static var phone: String {
        get {
            return loadUser()?.phone ?? ""
        }
    }

    static var password: String {
        get {
            return loadUser()?.password ?? ""
        }
    }

    static var categories: Int {
        get {
            return loadUser()?.categories ?? 0
        }
    }

    static var waitingNotes: Int {
        get {
            return loadUser()?.waitingNotes ?? 0
        }
    }

    static var doneNotes: Int {
        get {
            return loadUser()?.doneNotes ?? 0
        }
    }
}

