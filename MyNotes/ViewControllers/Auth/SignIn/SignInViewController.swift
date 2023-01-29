//
//  SignInViewController.swift
//  MyNotes
//
//  Created by Anwar Alhayek on 09/11/2022.
//

import UIKit
import Firebase
import FirebaseAuth

class SignInViewController: UIViewController {

    @IBOutlet weak var lblSignIn: UILabel!
    @IBOutlet weak var lblStart: UILabel!
    @IBOutlet weak var lblDontHaveAccount: UILabel!

    @IBOutlet weak var btnSignUp: UIButton!

    @IBOutlet weak var btnSignIn: CustomButton!

    @IBOutlet weak var txtPassword: CustomTextFiled!
    @IBOutlet weak var txtEmail: CustomTextFiled!

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
        let vc: SignUpViewController = SignUpViewController.instantiate(appStoryboard: .Auth)
        vc._push()
    }

    @IBAction func btnSignIn(_ sender: Any) {
        view.endEditing(true)
        self.signUp()
    }
}


extension SignInViewController {

    func setupView() {
        self.txtPassword.isSecureTextEntry = true
        self.txtEmail.keyboardType = .emailAddress
    }

    func localized() {
        self.lblStart.text = START_TITLE
        self.lblSignIn.text = SIGN_IN_TITLE
        self.lblDontHaveAccount.text = DONT_HAVE_ACCOUNT_TITLE
        self.btnSignUp.setTitle(SIGN_UP_TITLE, for: .normal)
        self.txtEmail.placeholder = EMAIL_TITLE
        self.txtPassword.placeholder = PASSWORD_TITLE
        self.btnSignIn.title = LOGIN_TITLE
    }

    func setupData() {

    }

    func fetchData() {

    }

}

extension SignInViewController {

    func signUp() {
        let vc: CategoriesViewController = CategoriesViewController.instantiate(appStoryboard: .Main)
        let email = self.txtEmail.text
        let password = self.txtPassword.text

        if self.isTextEmpty(texts: [email, password]) {
            return
        }

        let user = User.init(email: email, password: password)
        let userController = UserController()
        userController.signInByEmail(user: user) {
            vc._rootPush()
        }
    }
}



