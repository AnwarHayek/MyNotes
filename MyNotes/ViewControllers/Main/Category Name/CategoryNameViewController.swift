//
//  CategoryNameViewController.swift
//  MyNotes
//
//  Created by Anwar Alhayek on 12/11/2022.
//

import UIKit

class CategoryNameViewController: UIViewController {

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
    
}

extension CategoryNameViewController {

    func setupView() {
        self.navigationItem.title = CATEGORIES_TITLE
        self.rightBarButtonItem(action: #selector(addAction), image: "ic_Add")
        //TableView
        self.tableView._registerCell = CategoryName.self
        self.tableView.cellIdentifier = "CategoryName"
        self.tableView.cellHeight = 115
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

extension CategoryNameViewController {

    @objc func addAction() {
        let vc: NewNoteViewController = NewNoteViewController.instantiate(appStoryboard: .Main)
        vc._push()
    }

}

