//
//  EmptyDataSet.swift
//  MyNotes
//
//  Created by Anwar Alhayek on 24/01/2023.
//

import Foundation
import UIKit

extension UITableView {
    func emptyDataSet(isShow: Bool = true, imageHeight: CGFloat = 200, headerHeight: CGFloat = 400, message: String = "", messageFont: UIFont, image: String = "") {

        let height = self.frame.height
        let width = self.frame.width

        //_________Create Super View_________
        let superView = UIView.init(frame: CGRect(x: 0, y: 0, width: width, height: height))

        if isShow == true {
            //_________Create Stack_________
            let stackView = UIStackView.init(frame: CGRect(x: 0, y: 0, width: superView.frame.width, height: superView.frame.height))
            stackView.axis = NSLayoutConstraint.Axis.vertical
            stackView.alignment = UIStackView.Alignment.center
            stackView.distribution = UIStackView.Distribution.fill
            stackView.spacing = 20

            //_________Create Stack_________
            let suberStackView = UIStackView.init(frame: CGRect(x: 0, y: 0, width: superView.frame.width, height: superView.frame.height))
            suberStackView.axis = NSLayoutConstraint.Axis.horizontal
            suberStackView.alignment = UIStackView.Alignment.center

            //_________Create Label_________
            let label = UILabel()
            label.text = message
            label.textAlignment = .center
            label.font = messageFont
            label.numberOfLines = 0

            //_________Create imageView
            let imageView = UIImageView.init(frame: CGRect(x: 0, y: 0, width: superView.frame.width, height: superView.frame.height))
            imageView.image = image._toImage
            imageView.contentMode = UIView.ContentMode.scaleAspectFill//.scaleAspectFill

            suberStackView.addArrangedSubview(stackView)
            stackView.addArrangedSubview(imageView)
            stackView.addArrangedSubview(label)
            superView.addSubview(suberStackView)
            self.backgroundView = superView
        } else {
            self.backgroundView = nil
        }
    }
}
