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
//let BLACK_AND_WHITE = "BlackAndWhite"._colorNamed ?? UIColor.black
let NAVY_COLOR = "#23203F"._color

// MARK: - Enum
enum AppStoryboard: String {
    case Auth = "Auth"
    case Main = "Main"
}
