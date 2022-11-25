//
//  CategoriesCell.swift
//  MyNotes
//
//  Created by Anwar Alhayek on 12/11/2022.
//

import UIKit

class CategoriesCell: GeneralTableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        self.spaceBetweenCell = 10
    }

    override func configerCell() { }

    override func didselect(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc: NotesViewController = NotesViewController.instantiate(appStoryboard: .Main)
        vc._push()
    }
}
