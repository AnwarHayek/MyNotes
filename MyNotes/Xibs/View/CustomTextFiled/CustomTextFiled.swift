//
//
//  CustomTextFiled.swift
//  MyNotes
//
//  Created by Anwar Alhayek on 09/11/2022.
//

import UIKit

class CustomTextFiled: UIView {

    // MARK: @IBOutlet
    @IBOutlet weak var contentView: UIView!

    @IBOutlet weak var textFiled: UITextField!

    // MARK: Properties
    var style: Style = .email {
        didSet {
            self.applyStyle()
        }
    }

    var title: String? {
        didSet {
            self.applyStyle()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureXib()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureXib()
    }

    private func setupView() {
//        self.textFiled.applyStyle(._292929, .custom(.rubik_Regular, 15))
//        self.lblTitle.applyStyle(._949494, .custom(.rubik_Regular, 12))
    }

    enum Style {
        case email, password, name, phone, general
    }

    private func applyStyle() {
        switch self.style {
        case .name:
            self.textFiled.placeholder = self.title
        case .email:
            self.textFiled.placeholder = EMAIL_TITLE
            self.textFiled.keyboardType = .emailAddress
        case .password:
            self.textFiled.placeholder = self.title ?? PASSWORD_TITLE
            self.textFiled.isSecureTextEntry = true
        case .phone:
            self.textFiled.placeholder = PHONE_TITLE
            self.textFiled.keyboardType = .numberPad
        case .general:
            self.textFiled.placeholder = self.title
        }
        self.textFiled.setAttributedPlaceholder(color: "#9391A4"._color, font: ROBOTO_LIGHT22)
    }


    var text: String {
        get {
            return self.textFiled.getText
        }
    }
}


private extension CustomTextFiled {

    func configureXib() {
        let bundle = Bundle(for: CustomTextFiled.self)
        contentView = UINib(nibName: CustomTextFiled.id, bundle: bundle).instantiate(withOwner: self).first as? UIView
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.frame = bounds
        addSubview(contentView)
    }
}
