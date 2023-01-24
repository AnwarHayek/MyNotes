//
//  CGPointEx.swift
//  MyNotes
//
//  Created by Anwar Alhayek on 10/01/2023.
//

import Foundation
import UIKit

extension CGPoint {

    static var Center: CGPoint {
        return CGPoint(x: UIScreen.main.bounds.maxX / 2, y: UIScreen.main.bounds.maxY / 2)
    }

}
