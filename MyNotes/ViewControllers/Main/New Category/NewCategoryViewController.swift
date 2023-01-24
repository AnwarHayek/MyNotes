//
//  NewCategoryViewController.swift
//  MyNotes
//
//  Created by Anwar Alhayek on 12/11/2022.
//

import UIKit
import FirebaseDatabase

class NewCategoryViewController: UIViewController {

    var isUpdate: Bool = false

    var category: Category?

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
        view.endEditing(true)
        self.action()
    }
}

extension NewCategoryViewController {

    func setupView() {
        if isUpdate {
            self.btnSave.title = UPDATE_ITLE
            self.lblNewCategory.text = UPDATE_CATEGORY_TITLE
            self.lblCreateCategory.text = UPDATE_CATEGORY_TITLE
            self.txtCategory.textFiled.text = category?.categoryName ?? ""
            self.txtShortDescription.textFiled.text = category?.shortDescription ?? ""
        } else {
            self.btnSave.title = SAVE_TITLE
            self.lblNewCategory.text = NEW_CATEGORY_TITLE
            self.lblCreateCategory.text = CREATE_CATEGORY_TITLE
            self.txtCategory.placeholder = CATEGORY_NAME_TITLE
            self.txtShortDescription.placeholder = SHORT_DESCRIPTION_TITLE
        }
    }

    func localized() {

    }

    func setupData() {

    }

    func fetchData() {

    }

}

extension NewCategoryViewController {

    func action() {
        let categoryName = self.txtCategory.text
        let shortDescription = self.txtShortDescription.text
        let categories = Category.init(categoryName: categoryName, shortDescription: shortDescription)
        let categoriesController = CategoriesController()

        if isUpdate {
            updateCategory()
        } else {
            addCategory()
        }

        //addCategory
        func addCategory() {
            categoriesController.addCategory(category: categories) {
                self._showAlert(title: SUCCESS_TITLE, message: SUCCESS_ADD_CATEGORYS_MESSAGE) {
                    self._pop()
                }
            }
        }

        //Update Category
        func updateCategory() {
            categories.uid = self.category?.uid
            categories.dateCreated = self.category?.dateCreated
            categoriesController.updateCategory(category: categories) {
                self._showAlert(title: SUCCESS_TITLE, message: SUCCESS_UPDATE_CATEGORYS_MESSAGE) {
                    self._pop()
                }
            }
        }
    }
}
