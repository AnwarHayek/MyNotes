//
//
//  NotesCell.swift
//  MyNotes
//
//  Created by Anwar Alhayek on 22/11/2022.
//

import UIKit

class NotesCell: GeneralTableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        self.spaceBetweenCell = 10.5
    }

    override func configerCell() { }

    override func didselect(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { }
}
