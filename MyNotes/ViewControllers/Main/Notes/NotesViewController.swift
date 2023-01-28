//
//  NotesViewController.swift
//  MyNotes
//
//  Created by Anwar Alhayek on 22/11/2022.
//

import UIKit
import MagicalRecord

class NotesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var category: Category?

    var notes: [Note] = []

    let noteController = NoteController()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        localized()
        setupData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.emptyDataSet(message: WRITE_FIRST_CATEGORYS_MESSAGE, image: "ic_EmptyTable")
    }

}

extension NotesViewController {

    func setupView() {
        self.navigationItem.title = category?.categoryName ?? ""
        self.rightBarButtonItem(action: #selector(addAction), image: "ic_Add")
        //TableView
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView._registerCell = NotesCell.self
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
        vc.passingNote = { note in
            self.notes.append(note)
            self.tableView.reloadData()
        }
        vc.category = category
        vc._push()
    }

    func isDone(note: Note) {
        guard let category = self.category else { return }
        noteController.isDone(note: note, category: category)
    }
}

extension NotesViewController: UITableViewDelegate {

}

extension NotesViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: NotesCell = tableView._dequeueReusableCell()
        cell.object = notes[indexPath.item]
        cell.configerCell()
        return cell
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: nil) { (_, _, handeler) in
            guard let category = self.category else { return }

            self._showAlert(title: ALERT_TITLE, message: CONFIRMATION_NOTE_MESSAGE, buttonAction1: {
                self.noteController.deleteNote(note: self.notes[indexPath.item], category: category) {
                    self.notes.remove(at: indexPath.item)
                    self.tableView.deleteRows(at: [indexPath], with: .automatic)
                    self.tableView.emptyDataSet(message: WRITE_FIRST_CATEGORYS_MESSAGE, image: "ic_EmptyTable")
                }
            })
            handeler(true)
        }
        delete.image = "ic_Trash"._toImage
        let swipe = UISwipeActionsConfiguration(actions: [delete])
        swipe.performsFirstActionWithFullSwipe = true
        return swipe
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc: NewNoteViewController = NewNoteViewController.instantiate(appStoryboard: .Main)
        let myNote = self.notes[indexPath.item]
        vc.passingNote = { modifiedNote in
            let note = self.notes.filter { $0.uid == myNote.uid }.first
            note?.title = modifiedNote.title
            note?.description = modifiedNote.description
            self.tableView.reloadData()
        }
        vc.note = myNote
        vc.category = self.category
        vc.isUpdate = true
        vc._push()
    }
}


