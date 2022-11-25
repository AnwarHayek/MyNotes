//
//  CategoriesViewController.swift
//  MyNotes
//
//  Created by Anwar Alhayek on 12/11/2022.
//

import UIKit

class CategoriesViewController: UIViewController {

    @IBOutlet weak var tableView: GeneralTableView!

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

    @IBAction func btnNewCategory(_ sender: Any) {
        let vc: NewCategoryViewController = NewCategoryViewController.instantiate(appStoryboard: .Main)
//        vc._push()
    }

}

extension CategoriesViewController {

    func setupView() {
        self.navigationItem.title = CATEGORIES_TITLE
        self.rightBarButtonItem(action: #selector(settingAction), image: "ic_Setting")
        //TableView
        self.tableView._registerCell = CategoriesCell.self
        self.tableView.cellIdentifier = "CategoriesCell"
        self.tableView.cellHeight = 70
        let array = [",", ""]
        self.tableView.object = array
        self.tableView.contentInset = UIEdgeInsets(top: 17, left: 0, bottom: 0, right: 0)
    }

    func localized() {

    }

    func setupData() {

    }

    func fetchData() {

    }

}

extension CategoriesViewController {

    @objc func settingAction() {
        let vc: SettingsViewController = SettingsViewController.instantiate(appStoryboard: .Settings)
        vc._push()
    }

}
