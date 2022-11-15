//
//
//  SettingsCell.swift
//  MyNotes
//
//  Created by Anwar Alhayek on 15/11/2022.
//

import UIKit

class SettingsCell: GeneralTableViewCell {

    @IBOutlet weak var rightView: UIView!
    @IBOutlet weak var leftView: UIView!

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!

    @IBOutlet weak var imgIcon: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.spaceBetweenCell = 10
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
        if index == 0 {
            self.showActionSheet()
        } else if index == 1 {
            let vc: ProfileViewController = ProfileViewController.instantiate(appStoryboard: .Settings)
            vc._push()
        } else if index == 2 {
            let vc: AboutAppViewController = AboutAppViewController.instantiate(appStoryboard: .Settings)
            vc._push()
        } else if index == 3 {
            let vc: SignInViewController = SignInViewController.instantiate(appStoryboard: .Auth)
            vc._rootPush()
        }
    }

    func showActionSheet() {
        let arabic = UIAlertAction(title: ARABIC_TITLE, style: .default, handler: {
            (alert: UIAlertAction!) -> Void in })

        let english = UIAlertAction(title: ENGLISH_TITLE, style: .default, handler: {
            (alert: UIAlertAction!) -> Void in })

        let cancel = UIAlertAction(title: CANCEL_TITLE, style: .cancel, handler: {
            (alert: UIAlertAction!) -> Void in })

        if let parent = _topVC as? SettingsViewController {
            parent._presentActionSheet(actions: arabic, english, cancel)
        }
    }
}

