//
//  CustomButton.swift
//  MyNotes
//
//  Created by Anwar Alhayek on 09/11/2022.
//

import Foundation
import UIKit

class CustomButton: UIButton {
    
    let indicator = CircleStrokeSpin()

    var indicatorLayer: CALayer?
    
    var title: String? {
        didSet {
            self.setTitle(title, for: .normal)
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
    
    func addIndicator() {
        guard indicatorLayer == nil else { return }
        let indicatorSize = 30
        let indicatorColor = UIColor.white
        self.indicatorLayer = CALayer()
        self.indicatorLayer?.frame = self.bounds
        self.layer.addSublayer(indicatorLayer!)
        self.indicator.setUpAnimation(in: indicatorLayer!, circleSize: indicatorSize, color: indicatorColor)
        self.tintColor = .clear
        self.isEnabled = false
    }

    func removeIndicator() {
        indicatorLayer?.removeFromSuperlayer()
        indicatorLayer = nil
        self.tintColor = .white
        self.isEnabled = true
    }
}
