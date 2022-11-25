//
//  SettingsViewController.swift
//  MyNotes
//
//  Created by Anwar Alhayek on 15/11/2022.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var tableView: GeneralTableView!

    @IBOutlet weak var lblCharacter: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblName: UILabel!

    var objects = [Settings.init(image: "ic_Language", title: LANGUAGE_TITLE, description: SELECTED_LANGUDE_TITLE),
        Settings.init(image: "ic_Profile", title: PROFILE_TITLE, description: UPDATE_DATA_TITLE),
        Settings.init(image: "ic_About App", title: APOUTAPP_TITLE, description: WHAT_IS_TITLE),
        Settings.init(image: "ic_Logout", title: LOGOUT_TITLE, description: WAITING_TITLE)]

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

extension SettingsViewController {

    func setupView() {
        self.lblName.text = "\(UserData.firstName + " " + UserData.lastName)"
        self.lblEmail.text = UserData.email
        self.lblCharacter.text = "\(UserData.firstName.first ?? " ")"
        //TableView
        self.tableView._registerCell = SettingsCell.self
        self.tableView.cellIdentifier = "SettingsCell"
        self.tableView.cellHeight = 70
        self.tableView.object = objects
    }

    func localized() {
        self.navigationItem.title = SETTINGS_TITLE
    }

    func setupData() {
    }

    func fetchData() {

    }

}

extension SettingsViewController {

    func showActionSheet() {
        let arabic = UIAlertAction(title: ARABIC_TITLE, style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            self._showAlert(title: ALERT_TITLE, message: EDITE_LANGUGE_TITLE) {
                UserProfile.shared.setAppleLAnguageTo(lang: "ar")
                exit(0)
            }
        })

        let english = UIAlertAction(title: ENGLISH_TITLE, style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            self._showAlert(title: ALERT_TITLE, message: EDITE_LANGUGE_TITLE) {
                UserProfile.shared.setAppleLAnguageTo(lang: "en")
                exit(0)
            }
        })

        let cancel = UIAlertAction(title: CANCEL_TITLE, style: .cancel, handler: {
            (alert: UIAlertAction!) -> Void in })

        self._presentActionSheet(actions: arabic, english, cancel)
    }

    func signOut() {
        let vc: SignInViewController = SignInViewController.instantiate(appStoryboard: .Auth)
        let userController = UserController()

        self._showAlert(title: ALERT_TITLE, message: LOGOUT_MESSAGE, buttonAction1: {
            userController.signOut { error in
                vc._rootPush()
            }
        })
    }
}

