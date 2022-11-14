//
//  GeneralTableView.swift
//  MyNotes
//
//  Created by Anwar Alhayek on 12/11/2022.
//

import Foundation
import UIKit

class GeneralTableView: UITableView {

    var cellIdentifier: String?

    var cellHeight: CGFloat = 0

    var object: [Any] = []

    var selectHandler: ((_ indexPath: IndexPath) -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        self.delegate = self
        self.dataSource = self
    }
}

// MARK: - UITableViewDelegate
extension GeneralTableView: UITableViewDelegate {

}

// MARK: - UITableViewDataSource
extension GeneralTableView: UITableViewDataSource {

    // MARK: Cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cellIdentifier = self.cellIdentifier else { return UITableViewCell() }
        let cell = self.dequeueReusableCell(withIdentifier: cellIdentifier) as! GeneralTableViewCell
        let object = self.object[indexPath.item]
        cell.index = indexPath.item
        cell.object = object
        cell.configerCell()
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return self.object.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        On ViewController
        self.selectHandler?(indexPath)

        //On Cell
        if let cell = tableView.cellForRow(at: indexPath) as? GeneralTableViewCell {
            cell.didselect(tableView, didSelectRowAt: indexPath)
        }
    }
}
