//
//  Date.swift
//  ysCommonExtensions
//
//  Created by Ethan Lee on 2022/05/11.
//

import Foundation

extension Date {
    
    func toString(format: String = "yyyyMMdd_HHmmss") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    func dateAfteYears(years: Int) -> Date? {
        return Calendar.current.date(byAdding: .year, value: years, to: self)
    }
    
    func dateAfterDays(days: Int) -> Date? {
        return Calendar.current.date(byAdding: .day, value: days, to: self)
    }
    
}
