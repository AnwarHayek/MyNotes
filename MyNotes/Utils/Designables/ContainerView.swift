//
//  ContainerView.swift
//  MyNotes
//
//  Created by Anwar Alhayek on 11/11/2022.
//

import Foundation
import UIKit

class ContainerView: UIView {
    override func layoutSubviews() {
        super.layoutSubviews()
        self.cornerRadius = 8
        self.shadowColor = UIColor.black
        self.shadowOffset = CGSize(width: 0, height: 3)
        self.shadowOpacity = 0.16
        self.shadowRadius = 4.0
        self.backgroundColor = .white
    }
}
