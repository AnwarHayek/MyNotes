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
}
