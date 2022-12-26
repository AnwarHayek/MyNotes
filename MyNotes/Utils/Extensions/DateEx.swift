//
//  DateEx.swift
//  MyNotes
//
//  Created by Anwar Alhayek on 16/12/2022.
//

import Foundation

extension Date {

    var _stringData: String {
        return self._string(dataFormat: DATE_FORMAT)
    }

    func _string(dataFormat: String, timeZone: String = TimeZone.current.identifier) -> String {
        let formatter = DateFormatter()
        formatter.calendar = Calendar.init(identifier: .gregorian)
        formatter.dateFormat = dataFormat
        formatter.timeZone = TimeZone.init(identifier: timeZone)
        return formatter.string(from: self)
    }

    func dateFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DATE_FORMAT
        dateFormatter.locale = Locale(identifier: "en")
        dateFormatter.timeZone = TimeZone(identifier: "GMT")
        return dateFormatter.string(from: self)
    }
}
