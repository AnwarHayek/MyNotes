//
//  UIButtonEx.swift
//  MyNotes
//
//  Created by Anwar Alhayek on 09/12/2022.
//

import Foundation
import UIKit

extension UIButton {
    
    @IBInspectable var selectedImage: UIImage? {
        set {
            self.setImage(newValue, for: .selected)
        }
        get {
            return self.image(for: .selected)
        }
    }
}


