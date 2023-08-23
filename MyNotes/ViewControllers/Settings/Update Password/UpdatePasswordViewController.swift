//
//  UpdatePasswordViewController.swift
//  MyNotes
//
//  Created by Anwar Alhayek on 02/01/2023.
//

import UIKit

class UpdatePasswordViewController: UIViewController {

    @IBOutlet weak var btnSave: CustomButton!

    @IBOutlet weak var lblUpdatePassword: UILabel!

    @IBOutlet weak var txtOldPassword: CustomTextFiled!
    @IBOutlet weak var txtNewPassword: CustomTextFiled!
    @IBOutlet weak var txtConfirmPassword: CustomTextFiled!

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

    @IBAction func btnSave(_ sender: Any) {
        view.endEditing(true)
        self.updatePassword()
    }
}

extension UpdatePasswordViewController {

    func setupView() {
        self.txtOldPassword.style = .password
        self.txtOldPassword.title = OLD_PASSWORD_TITLE
        self.txtNewPassword.style = .password
        self.txtNewPassword.title = NEW_PASSWORD_TITLE
        self.txtConfirmPassword.style = .password
        self.txtConfirmPassword.title = CONFIRM_PASSWORD_TITLE


    }
    func localized() {
        self.lblUpdatePassword.text = UPDATE_PASSWORD_TITLE

        self.btnSave.title = SAVE_TITLE
//
    }

    func setupData() {

    }

    func fetchData() {

    }

}
extension UpdatePasswordViewController {

    func updatePassword() {
        let oldPassword = self.txtOldPassword.text
        let newPassword = self.txtNewPassword.text
        let confirmPassword = self.txtConfirmPassword.text
        let userController = AuthController()

        if self.isTextEmpty(texts: [oldPassword, newPassword, confirmPassword]) {
            return
        } else if oldPassword != UserData.password {
            FailureResponse.shared.showError(message: PASSWORD_INCORRECT_MESSAGE)
            return
        } else if newPassword != confirmPassword {
            FailureResponse.shared.showError(message: PASSWORDS_MATCH_TITLE)
            return
        }

        userController.changePassword(password: newPassword) {
            self._showAlert(title: SUCCESS_TITLE, message: PASSWORDـCHANGED_MESSAGE) {
                self._pop()
            }
        }
    }
}


