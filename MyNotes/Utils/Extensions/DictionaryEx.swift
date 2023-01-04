//
//  DictionaryEx.swift
//  MyNotes
//
//  Created by Anwar Alhayek on 31/12/2022.
//

import Foundation

extension Dictionary {

    func castToObject<T: Decodable>() -> T? {
        let json = try? JSONSerialization.data(withJSONObject: self)
        return json == nil ? nil : try? JSONDecoder().decode(T.self, from: json!)
    }
}


