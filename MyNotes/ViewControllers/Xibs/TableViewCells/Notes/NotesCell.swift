//
//
//  NotesCell.swift
//  MyNotes
//
//  Created by Anwar Alhayek on 22/11/2022.
//

import UIKit

class NotesCell: GeneralTableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!

    @IBOutlet weak var btnIsDone: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
    }

    override func configerCell() {
        if let _object = self.object as? Note {
            self.lblTitle.text = _object.title
            self.lblDescription.text = _object.description
            self.btnIsDone.isSelected = _object.isDone ?? false
        }
    }

    @IBAction func btnIsDone(_ sender: Any) {
        guard let parent = _topVC as? NotesViewController, let _object = self.object as? Note else { return }
        if let index = parent.notes.firstIndex(where: { $0.uid == _object.uid }) {
            self.btnIsDone.isSelected.toggle()
            parent.notes[index].isDone = self.btnIsDone.isSelected
            parent.isDone(note: parent.notes[index])
        }

    }
}
