//
//  UITextFieldEx.swift
//  MyNotes
//
//  Created by Anwar Alhayek on 11/11/2022.
//

import Foundation
import UIKit

extension UITextField {

    open override func awakeFromNib() {
        super.awakeFromNib()
        if textAlignment == .natural {
            let isRTL = UIApplication.shared.userInterfaceLayoutDirection == .rightToLeft
            if isRTL {
                self.textAlignment = .right
            } else {
                self.textAlignment = .left
            }
        }
    }

    @IBInspectable var placeholderColor: UIColor {
        set {
            self.attributedPlaceholder = NSAttributedString(string: self.attributedPlaceholder?.string ?? "Text", attributes: [NSAttributedString.Key.foregroundColor: newValue])
        }
        get {
            return .gray
        }
    }

    var _placeholderFont: UIFont {
        set {
            self.attributedPlaceholder = NSAttributedString(string: self.attributedPlaceholder?.string ?? "Text", attributes: [NSAttributedString.Key.font: newValue])
        }
        get {
            return SYSTEM_LIGHT_FONT22
        }
    }

    var getText: String {
        if !isSecureTextEntry {
            return self.text?._removeWhiteSpace ?? ""
        }
        return self.text ?? ""
    }
}


