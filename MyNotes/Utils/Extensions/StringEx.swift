//
//  StringEx.swift
//  MyNotes
//
//  Created by Anwar Alhayek on 09/11/2022.
//

import Foundation
import UIKit

extension String {

    var _color: UIColor {
        return UIColor.init(named: self) ?? UIColor.init(hexString: self)
    }

    var _colorcg: CGColor {
        return self._color.cgColor
    }

    var _toImage: UIImage? {
        return UIImage.init(named: self)
    }

    var _localize: String {
        return NSLocalizedString(self, comment: "")
    }

    var _removeWhiteSpace: String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
