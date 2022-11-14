//
//  MainNavigationViewController.swift
//  MyNotes
//
//  Created by Anwar Alhayek on 09/11/2022.
//

import UIKit

class MainNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        AppDelegate.shared?.rootNavigationController = self
        self.setRoot()
        self.setUpNavigation()
    }
}

extension MainNavigationViewController {

    func setRoot() {
        let vc: CategoriesViewController = CategoriesViewController.instantiate(appStoryboard: .Main)
        vc._rootPush()
    }

    func setUpNavigation() {
        //Clear Color to Back Title
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.clear], for: .normal)
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.clear], for: UIControl.State.highlighted)

        //Change Back Button Color
        UIBarButtonItem.appearance().tintColor = .black

        //Edit Font Small Title
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: NAVY_COLOR, NSAttributedString.Key.font: QUICKSAND_BOLD22]

        //Delete Shadow
        UINavigationBar.appearance().shadowImage = UIImage.init()

        //Edit Navigation Bar Color when sceoll ViewController
        UINavigationBar.appearance().barTintColor = .white

    }
}
