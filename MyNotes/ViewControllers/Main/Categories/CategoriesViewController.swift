//
//  CategoriesViewController.swift
//  MyNotes
//
//  Created by Anwar Alhayek on 12/11/2022.
//

import UIKit

class CategoriesViewController: UIViewController {

    @IBOutlet weak var tableView: GeneralTableView!

    var categories: [Any] = []

    let control = UIRefreshControl.init()

    let categoriesController = CategoriesController()

    var isShowLoader: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        localized()
        setupData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
    }

    @IBAction func btnNewCategory(_ sender: Any) {
        let vc: NewCategoryViewController = NewCategoryViewController.instantiate(appStoryboard: .Main)
         vc._push()
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
        self.tableView.contentInset = UIEdgeInsets(top: 17, left: 0, bottom: 0, right: 0)
    }

    func localized() {

    }

    func setupData() {

    }

    func fetchData() {
        self.categories.removeAll()
        categoriesController.getCategory { categories, showLocalData in
            self.categories = categories

            if showLocalData {
                let categories = TCategories.mr_findAll() as? [TCategories] ?? []
                self.categories = categories
            }

            self.tableView.object = self.categories
            self.tableView.reloadData()
            self.tableView.emptyDataSet(message: WRITE_FIRST_CATEGORYS_MESSAGE, image: "ic_EmptyTable")
            self.control.endRefreshing()
        }
    }
}

extension CategoriesViewController {

    @objc func settingAction() {
        let vc: SettingsViewController = SettingsViewController.instantiate(appStoryboard: .Settings)
        vc._push()
    }

    func deleteCategory(category: Category) {
        self._showAlert(title: ALERT_TITLE, message: CONFIRMATION_CATEGORYS_MESSAGE, buttonAction1: {
            self.categoriesController.deleteCategory(category: category) {
                self.fetchData()
            }
        })
    }
}

