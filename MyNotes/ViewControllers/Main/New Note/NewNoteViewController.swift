//
//  NewNoteViewController.swift
//  MyNotes
//
//  Created by Anwar Alhayek on 12/11/2022.
//

import UIKit

class NewNoteViewController: UIViewController {

    @IBOutlet weak var lblNewNote: UILabel!
    @IBOutlet weak var lblCreateNote: UILabel!

    @IBOutlet weak var txtNoteTitle: CustomTextFiled!
    @IBOutlet weak var txtDescription: CustomTextFiled!

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

extension NewNoteViewController {

    func setupView() {
        self.lblNewNote.text = NEW_NOTE_TITLE
        self.lblCreateNote.text = CREATE_NOTE_TITLE
        self.btnSave.title = SAVE_TITLE
        self.txtDescription.placeholder = DESCRIPTION_TITLE
        self.txtNoteTitle.placeholder = NOTE_TITLE_TITLE
    }

    func localized() {

    }

    func setupData() {

    }

    func fetchData() {

    }

}

