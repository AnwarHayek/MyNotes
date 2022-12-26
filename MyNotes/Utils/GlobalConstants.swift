//
//  GlobalConstants.swift
//  MyNotes
//
//  Created by Anwar Alhayek on 09/11/2022.
//

import Foundation
import UIKit

// MARK: - Fonts
let ROBOTO_MEDIUM20 = UIFont.init(name: "Roboto-Medium", size: 20)
let ROBOTO_LIGHT22 = UIFont.init(name: "Roboto-Light", size: 22) ?? SYSTEM_LIGHT_FONT22
let QUICKSAND_BOLD22 = UIFont.init(name: "Quicksand-Bold", size: 22) ?? SYSTEM_BOLD_FONT22

let SYSTEM_LIGHT_FONT22 = UIFont.systemFont(ofSize: 22, weight: .light)
let SYSTEM_BOLD_FONT22 = UIFont.systemFont(ofSize: 22, weight: .bold)

// MARK: - Color
let NAVY_COLOR = "#23203F"._color

// MARK: - Collection names in firestore Database
let USERS = "Users"
let CATEGORIES = "Categories"

// MARK: - UserDefult
let USER_KEY = "USER"
let ID_KEY = "ID"

// MARK: - Error
let EMPTY_FIELDS_ERROR = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: EMPTY_FIELDS_MESSAGE])
let INTERNET_NOT_AVAILABLE_ERROR = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: INTERNET_NOT_AVAILABLE_MESSAGE])

// MARK: - Format
let DATE_FORMAT = "yyyy-MM-dd HH:mm:ss"
let TIME_FORMAT = "h:mm a"

// MARK: - Enum
enum AppStoryboard: String {
    case Auth = "Auth"
    case Main = "Main"
    case Settings = "Settings"
}

// MARK: - Function
func checkInternet() -> Bool {
    if Reachability.isConnectedToNetwork() == false {
        FailureResponse.shared.showError(error: INTERNET_NOT_AVAILABLE_ERROR)
        return false
    }
    return true
}


