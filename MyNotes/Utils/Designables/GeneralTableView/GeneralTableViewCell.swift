//
//  GeneralTableViewCell.swift
//  MyNotes
//
//  Created by Anwar Alhayek on 12/11/2022.
//

import Foundation
import UIKit

class GeneralTableViewCell: UITableViewCell {

    var spaceBetweenCell: CGFloat?

    var object: Any?

    var index: Int? = 0

    func configerCell() { }

    func didselect(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { }

    override open var frame: CGRect {
        get {
            return super.frame
        }
        set (newFrame) {
            var frame = newFrame
            frame.size.height -= spaceBetweenCell ?? 0
            super.frame = frame
        }
    }
}
