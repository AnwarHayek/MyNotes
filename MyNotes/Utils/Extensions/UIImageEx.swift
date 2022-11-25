//
//  UIImageEx.swift
//  MyNotes
//
//  Created by Anwar Alhayek on 22/11/2022.
//

import Foundation
import UIKit

extension UIImageView {

    func flipInRTL() {
        if let _img = image {
            image = _img.imageFlippedForRightToLeftLayoutDirection()
        }
    }
}
