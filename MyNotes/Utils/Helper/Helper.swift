//
//  Helper.swift
//  MyNotes
//
//  Created by Anwar Alhayek on 24/11/2022.
//

import Foundation

class Helper {

    class func showLoader(isLoading: Bool = true) {
       
        if isLoading {
            ProgressHUD.showIndicator()
        } else {
            ProgressHUD.dismiss()
        }
    }
}
