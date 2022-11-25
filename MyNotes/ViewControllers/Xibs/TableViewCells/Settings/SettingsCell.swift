//
//
//  SettingsCell.swift
//  MyNotes
//
//  Created by Anwar Alhayek on 15/11/2022.
//

import UIKit

class SettingsCell: GeneralTableViewCell {

    @IBOutlet weak var imgArrow: UIImageView!

    @IBOutlet weak var rightView: UIView!
    @IBOutlet weak var leftView: UIView!

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!

    @IBOutlet weak var imgIcon: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.spaceBetweenCell = 10
        self.imgArrow.flipInRTL()
    }

    override func configerCell() {
        if let _object = self.object as? Settings {
            self.hideView(index: self.index)
            self.lblTitle.text = _object.title
            self.lblDescription.text = _object.description
            self.imgIcon.image = _object.image
        }
    }

    override func didselect(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.cellAction(index: indexPath.item)
    }

    func hideView(index: Int?) {
        guard let _index = index else { return }
        if _index % 2 == 0 {
            self.rightView.isHidden = true
        } else {
            self.leftView.isHidden = true
        }
    }

    func cellAction(index: Int) {
        guard let parent = _topVC as? SettingsViewController else { return }

        if index == 0 {
            parent.showActionSheet()
        } else if index == 1 {
            let vc: ProfileViewController = ProfileViewController.instantiate(appStoryboard: .Settings)
            vc._push()
        } else if index == 2 {
            let vc: AboutAppViewController = AboutAppViewController.instantiate(appStoryboard: .Settings)
            vc._push()
        } else if index == 3 {
            parent.signOut()
        }
    }
}

