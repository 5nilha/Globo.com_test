//
//  Date+Extension.swift
//  Globo.com_test
//
//  Created by Fabio Quintanilha on 12/7/19.
//  Copyright © 2019 FabioQuintanilha. All rights reserved.
//

import Foundation

extension Date {
    var formmatedDateForPortuguese: String {
        let formater = DateFormatter()
        formater.locale = Locale(identifier: "pt_BR")
        formater.dateFormat = "MMMM"  // "MMM" for short names and  MMMM for long names

        let monthString = formater.string(from: self).capitalized // "maio"
        let calendar = Calendar.current
        
        return "\(monthString) \(calendar.component(.year, from: self))"
    }
}
