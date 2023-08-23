//
//  ProfileViewController.swift
//  MyNotes
//
//  Created by Anwar Alhayek on 15/11/2022.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var imgArrow: UIImageView!

    @IBOutlet weak var btnSave: UIButton!

    @IBOutlet weak var lblCategories: UILabel!
    @IBOutlet weak var lblCategoriesNumber: UILabel!
    @IBOutlet weak var lblDoneNotes: UILabel!
    @IBOutlet weak var lblDoneNotesNumber: UILabel!
    @IBOutlet weak var lblWaitingNotes: UILabel!
    @IBOutlet weak var lblWaitingNotesNumber: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblCharacter: UILabel!

    @IBOutlet weak var txtPassword: SettingsTextFiled!
    @IBOutlet weak var txtPhone: SettingsTextFiled!
    @IBOutlet weak var txtLastName: SettingsTextFiled!
    @IBOutlet weak var txtFirstName: SettingsTextFiled!

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
        self.updateUserData()
    }
}

extension ProfileViewController {

    func setupView() {
        self.lblName.text = "\(UserData.firstName + " " + UserData.lastName)"
        self.lblEmail.text = UserData.email
        self.lblCharacter.text = "\(UserData.firstName.first ?? " ")"
        self.lblCategoriesNumber.text = "\(UserData.categories)"
        self.lblWaitingNotesNumber.text = "\(UserData.waitingNotes)"
        self.lblDoneNotesNumber.text = "\(UserData.doneNotes)"

        self.txtFirstName.textFiled.text = UserData.firstName
        self.txtLastName.textFiled.text = UserData.lastName
        self.txtPhone.textFiled.text = UserData.phone
        self.txtPassword.textFiled.isUserInteractionEnabled = false

        self.txtPassword.addTapGuesture(target: self, action: #selector(self.updatePassword))
        self.imgArrow.flipInRTL()

    }

    func localized() {
        self.navigationItem.title = PROFILE_TITLE
        self.btnSave.setTitle(SAVE_TITLE, for: .normal)
        self.lblCategories.text = CATEGORYS_TITLE
        self.lblDoneNotes.text = DONE_NOTES_TITLE
        self.lblWaitingNotes.text = WAITING_NOTES_TITLE
        self.txtPassword.textFiled.text = ".  .  .  .  .  .  .  .  .  .  .  .  .  .  ."

    }

    func setupData() {

    }

    func fetchData() {

    }

}

extension ProfileViewController {

    @objc func updatePassword() {
        let vc: UpdatePasswordViewController = UpdatePasswordViewController.instantiate(appStoryboard: .Settings)
        vc._push()
    }

    func updateUserData() {
        let firstName = self.txtFirstName.text
        let lastName = self.txtLastName.text
        let phone = self.txtPhone.text
        let userController = AuthController()

        if self.isTextEmpty(texts: [firstName, lastName, phone]) {
            return
        } else if firstName == UserData.firstName && lastName == UserData.lastName && phone == UserData.phone {
            return
        }

        let user = User.init(firsName: firstName, lastName: lastName, phone: phone)
        userController.updateUserData(user: user) {
            self.lblName.text = "\(UserData.firstName + " " + UserData.lastName)"
            self.txtPhone.textFiled.text = UserData.phone
            self._showAlert(message: DATA_MODIFIED_MESSAGE)
        }
    }
}


