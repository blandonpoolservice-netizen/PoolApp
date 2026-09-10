//
//  Date+Weekday.swift
//  BlandonPoolService
//
//  Created by Omar Blandon on 9/6/26.
////
//  Date+Weekday.swift
//  BlandonPoolService
import Foundation

extension Date {
    var weekdayName: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        return formatter.string(from: self)
    }
}


