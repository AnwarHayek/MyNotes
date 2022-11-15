//
//  ProfileViewController.swift
//  MyNotes
//
//  Created by Anwar Alhayek on 15/11/2022.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var btnSave: UIButton!

    @IBOutlet weak var lblCategories: UILabel!
    @IBOutlet weak var lblCategoriesNumber: UILabel!
    @IBOutlet weak var lblDoneNotes: UILabel!
    @IBOutlet weak var lblDoneNotesNumber: UILabel!
    @IBOutlet weak var lblWaitingNotes: UILabel!
    @IBOutlet weak var lblWaitingNotesNumber: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblCharacter: UILabel!

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

extension ProfileViewController {

    func setupView() {

    }

    func localized() {
        self.navigationItem.title = PROFILE_TITLE
        self.btnSave.setTitle(SAVE_TITLE, for: .normal)
        self.lblCategories.text = CATEGORYS_TITLE
        self.lblDoneNotes.text = DONE_NOTES_TITLE
        self.lblWaitingNotes.text = WAITING_NOTES_TITLE
    }

    func setupData() {

    }

    func fetchData() {

    }

}

