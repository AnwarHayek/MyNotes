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

    // MARK: Outlets
    @IBOutlet weak var lblSignIn: UILabel!
    @IBOutlet weak var lblStart: UILabel!
    @IBOutlet weak var lblDontHaveAccount: UILabel!

    @IBOutlet weak var btnSignUp: UIButton!

    @IBOutlet weak var btnSignIn: CustomButton!

    @IBOutlet weak var txtPassword: CustomTextFiled!
    @IBOutlet weak var txtEmail: CustomTextFiled!

    private let userController = AuthController()


    // MARK: Life Cycle
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

}

// MARK: - Actions
private extension SignInViewController {
    @IBAction func btnSignUp(_ sender: Any) {
        let vc: SignUpViewController = SignUpViewController.instantiate(appStoryboard: .Auth)
        vc._push()
    }

    @IBAction func btnSignIn(_ sender: Any) {
        self.signIn()
    }
}


// MARK: - Configurations
private extension SignInViewController {

    func setupView() {

    }

    func localized() {
        self.lblStart.text = START_TITLE
        self.lblSignIn.text = SIGN_IN_TITLE
        self.lblDontHaveAccount.text = DONT_HAVE_ACCOUNT_TITLE
        self.btnSignUp.setTitle(SIGN_UP_TITLE, for: .normal)
        self.txtEmail.style = .email
        self.txtPassword.style = .password
        self.btnSignIn.title = LOGIN_TITLE
    }

    func setupData() {

    }

    func fetchData() {

    }

}

private extension SignInViewController {

    func signIn() {
        let vc: CategoriesViewController = CategoriesViewController.instantiate(appStoryboard: .Main)
        let email = self.txtEmail.text
        let password = self.txtPassword.text

        if self.isTextEmpty(texts: [email, password]) {
            return
        }
        self.addIndicator()
        self.userController.loginWithEmail(email: email, password: password) { user in
            guard user != nil else { self.removeIndicator();return }
            vc._rootPush()
            self.removeIndicator()
        }
    }

    func addIndicator() {
        self.btnSignIn.addIndicator()
        self.btnSignUp.isEnabled = false
    }

    func removeIndicator() {
        self.btnSignIn.removeIndicator()
        self.btnSignUp.isEnabled = true
    }
}



