//
//  AlertEx.swift
//  MyNotes
//
//  Created by Anwar Alhayek on 25/01/2023.
//

import Foundation
import UIKit

extension UIViewController {

    // MARK: Show Alert
    func _showAlert(title: String?, message: String?, buttonAction: @escaping (() -> Void)) {
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        let okayAction = UIAlertAction.init(title: OK_TITLE, style: .default) { action in
            buttonAction()
        }
        alert.addAction(okayAction)
        self.present(alert, animated: true, completion: nil)
    }

    func _showAlert(title: String?, message: String?, buttonTitle1: String = OK_TITLE, buttonTitle2: String = CANCEL_TITLE, buttonAction1: @escaping (() -> Void)) {
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        let okayAction = UIAlertAction.init(title: buttonTitle1, style: .default) { action in
            buttonAction1()
        }
        let cancelAction = UIAlertAction.init(title: buttonTitle2, style: .destructive) { action in
        }
        alert.addAction(okayAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }

    func _showAlert(message: String?) {
        let alert = UIAlertController.init(title: SUCCESS_TITLE, message: message, preferredStyle: .alert)
        let okayAction = UIAlertAction.init(title: OK_TITLE, style: .default) { action in
        }
        alert.addAction(okayAction)
        self.present(alert, animated: true, completion: nil)
    }

    func _showErrorAlert(message: String?) {
        let alert = UIAlertController.init(title: ERROR_TITLE, message: message, preferredStyle: .alert)
        let okayAction = UIAlertAction.init(title: OK_TITLE, style: .destructive, handler: nil)

        alert.addAction(okayAction)
        self.present(alert, animated: true, completion: nil)
    }
}
