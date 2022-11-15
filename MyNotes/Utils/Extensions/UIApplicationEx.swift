//
//  UIApplicationEx.swift
//  MyNotes
//
//  Created by Anwar Alhayek on 15/11/2022.
//

import Foundation
import UIKit

extension UIApplication {
    var currentWindow: UIWindow? {
        connectedScenes
            .filter({ $0.activationState == .foregroundActive })
            .map({ $0 as? UIWindowScene })
            .compactMap({ $0 })
            .first?.windows
            .filter({ $0.isKeyWindow }).first
    }
}
