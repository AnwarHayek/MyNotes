//
//  NotesViewController.swift
//  MyNotes
//
//  Created by Anwar Alhayek on 22/11/2022.
//

import UIKit

class NotesViewController: UIViewController {

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

extension NotesViewController {

    func setupView() {
        self.navigationItem.title = CATEGORIES_TITLE
        self.rightBarButtonItem(action: #selector(addAction), image: "ic_Add")
        //TableView
        self.tableView._registerCell = NotesCell.self
        self.tableView.cellIdentifier = "NotesCell"
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

extension NotesViewController {

    @objc func addAction() {
        let vc: NewNoteViewController = NewNoteViewController.instantiate(appStoryboard: .Main)
        vc._push()
    }
}

