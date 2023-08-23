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

    var category: Category?

    var isUpdate: Bool = false

    var note: Note?

    var passingNote: ((_ note: Note) -> Void)?

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

extension NewNoteViewController {

    func setupView() {
        if isUpdate {
            self.lblNewNote.text = UPDATE_NOTE_TITLE
            self.lblCreateNote.text = UPDATE_NOTE_TITLE
            self.btnSave.title = UPDATE_ITLE
            self.txtDescription.textFiled.text = note?.title ?? ""
            self.txtNoteTitle.textFiled.text = note?.description ?? ""
        } else {
            self.lblNewNote.text = NEW_NOTE_TITLE
            self.lblCreateNote.text = CREATE_NOTE_TITLE
            self.btnSave.title = SAVE_TITLE
            self.txtDescription.title = DESCRIPTION_TITLE
            self.txtDescription.style = .general
            self.txtNoteTitle.title = NOTE_TITLE_TITLE
            self.txtNoteTitle.style = .general

        }
    }

    func localized() {

    }

    func setupData() {

    }

    func fetchData() {

    }
}

extension NewNoteViewController {

    func action() {
        guard let category = self.category else { return }
        let noteTitle = self.txtNoteTitle.text
        let noteDescription = self.txtDescription.text
        let note = Note.init(title: noteTitle, description: noteDescription, isDone: "false")
        let noteController = NoteController()

        if self.isTextEmpty(texts: [noteTitle, noteDescription]) {
            return
        }

        if isUpdate {
            updateNote()
        } else {
            addNote()
        }

        //addNote
        func addNote() {
            noteController.addNote(note: note, category: category) {
                self._showAlert(title: SUCCESS_TITLE, message: SUCCESS_ADD_NOTE_MESSAGE) {
                    self.passingNote?(note)
                    self._pop()
                }
            }
        }

        //Update Note
        func updateNote() {
            note.uid = self.note?.uid
            noteController.updateNote(note: note, category: category) {
                self._showAlert(title: SUCCESS_TITLE, message: SUCCESS_UPDATE_NOTE_MESSAGE) {
                    self.passingNote?(note)
                    self._pop()
                }
            }
        }
    }
}
