//
//  Date+Ext.swift
//  tutorGitApp
//
//  Created by mehdimagerramov on 06.02.2024.
//

import Foundation

extension Date {
     
    func convertToMonthYearFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        return dateFormatter.string(from: self)
    }
}

