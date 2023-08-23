//
//  FailureResponse.swift
//  MyNotes
//
//  Created by Anwar Alhayek on 24/11/2022.
//

import Foundation

class FailureResponse {

    static let shared = FailureResponse()

    func showError(error: Error) {
        AppDelegate.shared?.rootNavigationController?._showErrorAlert(message: error.localizedDescription)
        Helper.showLoader(isLoading: false)
    }

    func showError(message: String) {
        let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: message])
        AppDelegate.shared?.rootNavigationController?._showErrorAlert(message: error.localizedDescription)
        Helper.showLoader(isLoading: false)
    }
}


class FailureResponsee {

    static let shared = FailureResponsee()

    func showError(error: Error?) -> Bool {
        if let error = error {
            AppDelegate.shared?.rootNavigationController?._showErrorAlert(message: error.localizedDescription)
            Helper.showLoader(isLoading: false)
            return false
        }
        return true
    }

    func showError(message: String) {
        let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: message])
        AppDelegate.shared?.rootNavigationController?._showErrorAlert(message: error.localizedDescription)
        Helper.showLoader(isLoading: false)
    }
}
