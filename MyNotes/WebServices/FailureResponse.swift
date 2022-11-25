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

    }

}
