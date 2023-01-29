//
//  SignUpViewController.swift
//  MyNotes
//
//  Created by Anwar Alhayek on 09/11/2022.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var lblSignUp: UILabel!
    @IBOutlet weak var lblCreateAccount: UILabel!

    @IBOutlet weak var txtFirstName: CustomTextFiled!
    @IBOutlet weak var txtLastName: CustomTextFiled!
    @IBOutlet weak var txtEmail: CustomTextFiled!
    @IBOutlet weak var txtPassword: CustomTextFiled!
    @IBOutlet weak var txtPhone: CustomTextFiled!

    @IBOutlet weak var btnSignUp: CustomButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        localized()
        setupData()
        fetchData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    @IBAction func btnSignUp(_ sender: Any) {
        view.endEditing(true)
        self.signUp()
    }
}

extension SignUpViewController {

    func setupView() {
        self.txtPassword.isSecureTextEntry = true
        self.txtPhone.keyboardType = .numberPad
        self.txtEmail.keyboardType = .emailAddress
    }

    func localized() {
        self.lblSignUp.text = SIGN_UP_TITLE
        self.lblCreateAccount.text = CREATE_ACCOUNT_TITLE
        self.btnSignUp.title = SIGN_UP_TITLE
        self.txtFirstName.placeholder = FIRST_NAME_TITLE
        self.txtLastName.placeholder = LAST_NAME_TITLE
        self.txtPhone.placeholder = PHONE_TITLE
        self.txtPassword.placeholder = PASSWORD_TITLE
        self.txtEmail.placeholder = EMAIL_TITLE
    }

    func setupData() {

    }

    func fetchData() {

    }

}

extension SignUpViewController {

    func signUp() {
        let vc: CategoriesViewController = CategoriesViewController.instantiate(appStoryboard: .Main)
        let email = self.txtEmail.text
        let password = self.txtPassword.text
        let firstName = self.txtFirstName.text
        let lastName = self.txtLastName.text
        let phone = self.txtPhone.text

        if self.isTextEmpty(texts: [email, password, firstName, lastName, phone]) {
            return
        }

        let user = User.init(firsName: firstName, lastName: lastName, email: email, phone: phone, password: password)
        let userController = UserController()
        userController.signUp(user: user) {
            vc._rootPush()
        }
    }
}
