//
//  DocumentReference.swift
//  MyNotes
//
//  Created by Anwar Alhayek on 21/08/2023.
//

import Foundation
import FirebaseFirestore

extension DocumentReference {

    func updateData(dic: [String: Any], completion: @escaping (() -> Void)) {
        self.updateData(dic) { error in
            guard FailureResponsee.shared.showError(error: error) else { return }
            completion()
        }
    }

    func setData(dic: [String: Any], completion: @escaping (() -> Void)) {
        Helper.showLoader(isLoading: false)
        self.setData(dic) { error in
            guard FailureResponsee.shared.showError(error: error) else { completion (); return }
            completion()
        }
    }

    func getDocument(completion: @escaping ((_ dic: [String: Any]) -> Void)) {
        self.getDocument { snapshot, error in
            guard FailureResponsee.shared.showError(error: error) else { completion([:]); return }
            if let dic = snapshot?.data() as? [String: Any] {
                completion(dic)
            }
        }
    }
}
