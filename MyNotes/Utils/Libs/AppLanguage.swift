//
//  AppLanguage.swift
//  MyNotes
//
//  Created by Anwar Alhayek on 25/01/2023.
//

import Foundation
import UIKit


enum Languages: String {
    case english = "en"
    case arabic = "ar"
}

class AppLanguage {

    static let shared = AppLanguage()

    let APPLE_LANGUAGE_KEY = "AppleLanguages"

    var isRTL: Bool {
        return UIApplication.shared.userInterfaceLayoutDirection == .rightToLeft
    }

    var currentLanguageKey: String? {
        let langs = UserDefaults.standard.value(forKey: APPLE_LANGUAGE_KEY) as? Array<String>
        return (langs?.first)
    }

    func currentAppleLanguage() -> String {
        let userdef = UserDefaults.standard
        let langArray = userdef.object(forKey: APPLE_LANGUAGE_KEY) as! NSArray
        let current = langArray.firstObject as! String
        let currentWithoutLocale = current._subString(from: 0, to: 2)
        return currentWithoutLocale
    }

    func setAppleLanguageTo(lang: Languages) {
        let userdef = UserDefaults.standard
        userdef.set([lang.rawValue, currentAppleLanguage()], forKey: APPLE_LANGUAGE_KEY)
        userdef.synchronize()
    }
}
