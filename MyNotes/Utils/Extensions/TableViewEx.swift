//
//  TableViewEx.swift
//  MyNotes
//
//  Created by Anwar Alhayek on 12/11/2022.
//

import Foundation
import UIKit

extension UITableView {

    //MARK: Register
    var _registerCell: UITableViewCell.Type {
        set {
            self.register(UINib(nibName: newValue.self._id, bundle: nil), forCellReuseIdentifier: newValue.self._id)
        }
        get {
            return UITableViewCell.self
        }
    }

    //MARK: Dequeue
    func _dequeueReusableCell<T: UITableViewCell>() -> T {
        guard let cell = dequeueReusableCell(withIdentifier: String(describing: T.self)) as? T else {
            fatalError("Could not locate viewcontroller with identifier \((T.self)._id) in storyboard.")
        }
        return cell
    }

}
