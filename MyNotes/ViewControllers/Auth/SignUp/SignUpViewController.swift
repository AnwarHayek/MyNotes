//
//  SignUpViewController.swift
//  MyNotes
//
//  Created by Anwar Alhayek on 09/11/2022.
//

import UIKit

class SignUpViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var lblSignUp: UILabel!
    @IBOutlet weak var lblCreateAccount: UILabel!

    @IBOutlet weak var txtFirstName: CustomTextFiled!
    @IBOutlet weak var txtLastName: CustomTextFiled!
    @IBOutlet weak var txtEmail: CustomTextFiled!
    @IBOutlet weak var txtPassword: CustomTextFiled!
    @IBOutlet weak var txtPhone: CustomTextFiled!

    @IBOutlet weak var btnSignUp: CustomButton!

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
private extension SignUpViewController {

    @IBAction func btnSignUp(_ sender: Any) {

        self.signUp()
    }
}

// MARK: - Configurations
private extension SignUpViewController {

    func setupView() {


    }

    func localized() {
        self.lblSignUp.text = SIGN_UP_TITLE
        self.lblCreateAccount.text = CREATE_ACCOUNT_TITLE
        self.btnSignUp.title = SIGN_UP_TITLE
        self.txtFirstName.style = .name
        self.txtFirstName.title = FIRST_NAME_TITLE

        self.txtLastName.style = .name
        self.txtLastName.title = LAST_NAME_TITLE

        self.txtPhone.style = .phone
        self.txtPassword.style = .password
        self.txtEmail.style = .email
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

        self.addIndicator()

        let user = User.init(firsName: firstName, lastName: lastName, email: email, phone: phone, password: password)
        let userController = AuthController()
        userController.registerWithEmail(user: user) { user in
            guard user != nil else { self.removeIndicator();return }
            vc._rootPush()
            self.removeIndicator()
        }
    }

    func addIndicator() {
        self.btnSignUp.addIndicator()
        self.navigationItem.hidesBackButton = true
    }

    func removeIndicator() {
        self.btnSignUp.removeIndicator()
        self.navigationItem.hidesBackButton = false
    }
}
