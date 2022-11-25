//
//  NewCategoryViewController.swift
//  MyNotes
//
//  Created by Anwar Alhayek on 12/11/2022.
//

import UIKit

class NewCategoryViewController: UIViewController {

    @IBOutlet weak var lblNewCategory: UILabel!
    @IBOutlet weak var lblCreateCategory: UILabel!

    @IBOutlet weak var txtCategory: CustomTextFiled!
    @IBOutlet weak var txtShortDescription: CustomTextFiled!

    @IBOutlet weak var btnSave: CustomButton!

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
    }

}

extension NewCategoryViewController {

    func setupView() {
        self.lblNewCategory.text = NEW_CATEGORY_TITLE
        self.lblCreateCategory.text = CREATE_CATEGORY_TITLE
        self.btnSave.title = SAVE_TITLE
        self.txtCategory.placeholder = CATEGORY_NAME_TITLE
        self.txtShortDescription.placeholder = SHORT_DESCRIPTION_TITLE
    }

    func localized() {

    }

    func setupData() {

    }

    func fetchData() {

    }

}

