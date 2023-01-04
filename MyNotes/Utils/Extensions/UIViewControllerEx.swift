//
//  UIViewControllerEx.swift
//  MyNotes
//
//  Created by Anwar Alhayek on 09/11/2022.
//

import Foundation
import UIKit

extension UIViewController {

    // MARK: Instantiate ViewController
    class func instantiate<T: UIViewController>(appStoryboard: AppStoryboard) -> T {
        let storyboard = UIStoryboard(name: appStoryboard.rawValue, bundle: nil)
        let identifier = String(describing: self)
        return storyboard.instantiateViewController(withIdentifier: identifier) as! T
    }

    // MARK: Push and Pop ViewController
    func _rootPush() {
        AppDelegate.shared?.rootNavigationController?.setViewControllers([self], animated: true)
    }

    func _push() {
        AppDelegate.shared?.rootNavigationController?.pushViewController(self, animated: true)
    }

    func _presentVC() {
        AppDelegate.shared?.rootNavigationController?.present(self, animated: true, completion: nil)
    }

    func _pop() {
        AppDelegate.shared?.rootNavigationController?.popViewController(animated: true)
    }

    // MARK: Customize BarButtonItem
    func customBarButtonItem(action: Selector, image: String, width: Double, height: Double) -> UIBarButtonItem {

        let backButton = UIButton(type: .custom)
        backButton.layer.masksToBounds = true
        backButton.frame = CGRect(x: 0.0, y: 0.0, width: width, height: height)
        backButton.contentMode = .scaleAspectFill
        backButton.addTarget(self, action: action, for: .touchUpInside)
        backButton.setImage(image._toImage, for: .normal)

        let profileBarItem = UIBarButtonItem(customView: backButton)
        return profileBarItem
    }

    func rightBarButtonItem(action: Selector, image: String, width: Double = 20, height: Double = 20) {
        self.navigationItem.rightBarButtonItem = customBarButtonItem(action: action, image: image, width: width, height: height)
    }

    // MARK: Show ActionSheet
    func _presentActionSheet(actions: UIAlertAction...) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        actions.forEach { alert.addAction($0) }
        self.present(alert, animated: true, completion: nil)
    }

    // MARK: Show Alert
    func _showAlert(title: String?, message: String?, buttonAction: @escaping (() -> Void)) {
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        let okayAction = UIAlertAction.init(title: OK_TITLE, style: .default) { action in
            buttonAction()
        }
        alert.addAction(okayAction)
        self.present(alert, animated: true, completion: nil)
    }

    func _showAlert(message: String?) {
        let alert = UIAlertController.init(title: SUCCESS_TITLE, message: message, preferredStyle: .alert)
        let okayAction = UIAlertAction.init(title: OK_TITLE, style: .default) { action in
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

    func _showErrorAlert(message: String?) {
        let alert = UIAlertController.init(title: "Error", message: message, preferredStyle: .alert)
        let okayAction = UIAlertAction.init(title: "OK", style: .destructive, handler: nil)

        alert.addAction(okayAction)
        self.present(alert, animated: true, completion: nil)
    }
}
