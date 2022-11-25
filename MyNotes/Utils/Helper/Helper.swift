//
//  Helper.swift
//  MyNotes
//
//  Created by Anwar Alhayek on 24/11/2022.
//

import Foundation
import ProgressHUD

class Helper {

    class func showLoader(isLoading: Bool = true, progress: CGFloat? = nil) {
        if let progress = progress, isLoading {
            ProgressHUD.showProgress(progress)
            return
        }
        if isLoading {
            ProgressHUD.showIndicator()
        } else {
            ProgressHUD.dismiss()
        }
    }
}
