//
//  Settings.swift
//  MyNotes
//
//  Created by Anwar Alhayek on 15/11/2022.
//

import Foundation
import UIKit

class Settings {

    var image: UIImage?
    var title: String?
    var description: String?

    init(image: String?, title: String?, description: String?) {
        self.image = image?._toImage
        self.title = title
        self.description = description
    }
}
