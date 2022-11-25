//
//  UserProfile.swift
//  MyNotes
//
//  Created by Anwar Alhayek on 22/11/2022.
//

import Foundation
import UIKit

class UserProfile {

    static let shared = UserProfile()

    let APPLE_LANGUAGE_KEY = "AppleLanguages"

    var isRTL: Bool {
        return UIApplication.shared.userInterfaceLayoutDirection == .rightToLeft
    }

    var currentLanguageKey: String? {
        let langs = UserDefaults.standard.value(forKey: "AppleLanguages") as? Array<String>
        return (langs?.first)
    }

    func currentAppleLanguage() -> String {
        let userdef = UserDefaults.standard
        let langArray = userdef.object(forKey: APPLE_LANGUAGE_KEY) as! NSArray
        let current = langArray.firstObject as! String
        let endIndex = current.startIndex
        let currentWithoutLocale = current._subString(from: 0, to: 2)
        return currentWithoutLocale
    }

    func currentAppleLanguageFull() -> String {
        let userdef = UserDefaults.standard
        let langArray = userdef.object(forKey: APPLE_LANGUAGE_KEY) as! NSArray
        let current = langArray.firstObject as! String
        return current
    }

    func setAppleLAnguageTo(lang: String) {
        let userdef = UserDefaults.standard
        userdef.set([lang, currentAppleLanguage()], forKey: APPLE_LANGUAGE_KEY)
        userdef.synchronize()
    }

}
