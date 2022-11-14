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
        let vc: CategoriesViewController = CategoriesViewController.instantiate(appStoryboard: .Main)
        vc._push()
    }
}

extension SignUpViewController {

    func setupView() {

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

