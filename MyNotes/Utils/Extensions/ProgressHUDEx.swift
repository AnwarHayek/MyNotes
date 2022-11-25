//
//  ProgressHUDEx.swift
//  MyNotes
//
//  Created by Anwar Alhayek on 24/11/2022.
//

import Foundation
import ProgressHUD

extension ProgressHUD {

    class func showIndicator() {
        ProgressHUD.show(interaction: false)
        ProgressHUD.colorAnimation = "#6A90F2"._color
        ProgressHUD.animationType = .circleSpinFade
    }

    class func showProgressHUD(_ progress: CGFloat) {
        ProgressHUD.show(interaction: false)
        ProgressHUD.colorAnimation = "#6A90F2"._color
        ProgressHUD.animationType = .circleSpinFade
        ProgressHUD.showProgress(progress)
    }

    class func dismissIndicator() {
        ProgressHUD.dismiss()
    }
}
