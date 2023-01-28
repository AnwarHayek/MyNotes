//
//  CategoriesViewController.swift
//  MyNotes
//
//  Created by Anwar Alhayek on 12/11/2022.
//

import UIKit
import EmptyDataSet_Swift

class CategoriesViewController: UIViewController {

    @IBOutlet weak var tableView: GeneralTableView!

    var categories: [Any] = []


    let categoriesController = CategoriesController()

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
            //When the internet is out
            if showLocalData {
                let categories = TCategories.mr_findAll() as? [TCategories] ?? []
                self.categories = categories
            }
            if self.categories.isEmpty {

            } else {
//                self.tableView.emptyDataSet(isShow: false)
            }
            self.tableView.object = self.categories

//            self.tableView.emptyDataSetView { view in
//                view.backgroundColor = .red
//                view.customView(UIView.init(frame: CGRect(x: 0, y: 0, width: 150, height: 150)))
//            }

            self.tableView.reloadData()
            self.tableView.emptyDataSet(message: WRITE_FIRST_CATEGORYS_MESSAGE, image: "ic_EmptyTable")


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

//
extension CategoriesViewController: EmptyDataSetSource, EmptyDataSetDelegate {

    func emptyDataSetShouldDisplay(_ scrollView: UIScrollView) -> Bool {
        return true
    }

    func emptyDataSetShouldAllowScroll(_ scrollView: UIScrollView) -> Bool {
        return true
    }

    func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        return NSAttributedString.init(string: "SORRY_TITLE", attributes: [NSAttributedString.Key.font: SYSTEM_BOLD_FONT22])
    }

    func description(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        return NSAttributedString.init(string: "NO_DATA_TITLE", attributes: [NSAttributedString.Key.font: SYSTEM_BOLD_FONT22])
    }
}
