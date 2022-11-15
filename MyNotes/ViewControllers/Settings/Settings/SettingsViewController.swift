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

    var objects = [Settings.init(image: "ic_Language", title: "Language", description: "Selected language: EN"),
        Settings.init(image: "ic_Profile", title: "Profile", description: "Update your data…"),
        Settings.init(image: "ic_About App", title: "About App", description: "What is notes app?"),
        Settings.init(image: "ic_Logout", title: "Logout", description: "Waiting your return…")]

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

