//
//  CustomButton.swift
//  MyNotes
//
//  Created by Anwar Alhayek on 09/11/2022.
//

import Foundation
import UIKit

class CustomButton: UIButton {
    
    var title: String? {
        didSet {
            self.setTitle(title, for: .normal)
            self.setTitleColor(.white, for: .normal)
            self.tintColor = .white
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.cornerRadius = self.frame.height / 2
        self.backgroundColor = "#6A90F2"._color
        self.clipsToBounds = true
        self.titleLabel?.font = ROBOTO_MEDIUM20
    }
}
