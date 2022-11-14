//
//
//  CustomTextFiled.swift
//  MyNotes
//
//  Created by Anwar Alhayek on 09/11/2022.
//

import UIKit

class CustomTextFiled: UIView {

    @IBOutlet weak var contentView: UIView!

    @IBOutlet weak var textFiled: UITextField!

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureXib()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureXib()
        self.textFiled._placeholderFont = ROBOTO_LIGHT22
    }

    private func configureXib() {
        Bundle.main.loadNibNamed(CustomTextFiled._id, owner: self, options: [:])
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(contentView)
        contentView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        contentView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        contentView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        contentView.layoutIfNeeded()
    }

    var keyboardType: UIKeyboardType {
        set {
            self.textFiled.keyboardType = newValue
        }
        get {
            return .default
        }
    }

    var isSecureTextEntry: Bool {
        set {
            self.textFiled.isSecureTextEntry = newValue
        }
        get {
            return false
        }
    }

    var placeholder: String? {
        set {
            self.textFiled.placeholder = newValue
        }
        get {
            return "placeholder"
        }
    }
}

