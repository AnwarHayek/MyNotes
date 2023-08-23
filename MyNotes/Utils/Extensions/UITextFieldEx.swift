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

    func setAttributedPlaceholder(color: UIColor, font: UIFont) {
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor: color, NSAttributedString.Key.font: font])
    }

    var getText: String {
        if !isSecureTextEntry {
            return self.text?._removeWhiteSpace ?? ""
        }
        return self.text ?? ""
    }
}


