//
//  AboutAppViewController.swift
//  MyNotes
//
//  Created by Anwar Alhayek on 13/11/2022.
//

import UIKit

class AboutAppViewController: UIViewController {

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

extension AboutAppViewController {

    func setupView() {
        self.navigationItem.title = ABOUT_APP
    }

    func localized() {

    }

    func setupData() {

    }

    func fetchData() {

    }

}

