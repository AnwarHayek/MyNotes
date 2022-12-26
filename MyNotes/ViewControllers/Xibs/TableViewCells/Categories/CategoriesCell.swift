//
//  CategoriesCell.swift
//  MyNotes
//
//  Created by Anwar Alhayek on 12/11/2022.
//

import UIKit

class CategoriesCell: GeneralTableViewCell {

    @IBOutlet weak var lblCategoryName: UILabel!
    @IBOutlet weak var lblShortDescription: UILabel!
    @IBOutlet weak var lblCharacter: UILabel!

    var notes: [Note] = []

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        self.spaceBetweenCell = 10
    }

    override func configerCell() {
        if let _object = self.object as? Category {
            self.lblCategoryName.text = _object.categoryName
            self.lblShortDescription.text = _object.shortDescription
            self.lblCharacter.text = "\(_object.categoryName?.uppercased().first ?? " ")"
        } else if let _object = self.object as? TCategories {
            self.lblCategoryName.text = _object.title
            self.lblShortDescription.text = _object.categorie_description
            self.lblCharacter.text = "\(_object.title?.uppercased().first ?? " ")"
        }
    }

    override func didselect(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc: NotesViewController = NotesViewController.instantiate(appStoryboard: .Main)

        if let _object = self.object as? Category {
            vc.category = _object
            vc.notes = _object.notes ?? []
            vc._push()
        } else if let _object = self.object as? TCategories {
            let category = Category.init(category: _object)
            let db_notes = _object.notes?.allObjects as? [TNote] ?? []

            for item in db_notes {
                if let note = Note.init(note: item) {
                    self.notes.append(note)
                }
            }
            vc.category = category
            vc.notes = notes
            vc._push()
        }
    }

    @IBAction func btnDelete(_ sender: Any) {
        guard let parent = _topVC as? CategoriesViewController, let _object = self.object as? Category else { return }
        parent.deleteCategory(category: _object)
    }

    @IBAction func btnEdit(_ sender: Any) {
        let vc: NewCategoryViewController = NewCategoryViewController.instantiate(appStoryboard: .Main)
        if let _object = self.object as? Category {
            vc.category = _object
            vc.isUpdate = true
            vc._push()
        }
    }
}
