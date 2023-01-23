//
//  CalendarHelper.swift
//  CalendarSwiftUI
//
//  Created by Callum Hill on 15/4/22.
//

import Foundation

class CalendarHelper {
    let calendar = Calendar.current
    let dateFormatter = DateFormatter()
    
    func monthYearString(_ date: Date) -> String {
        dateFormatter.dateFormat = "LLL yyyy"
        return dateFormatter.string(from: date)
    }
    
    func plusMonth(_ date: Date) -> Date {
        return date.addingTimeInterval(30 * 60 * 60 * 24)
    }
    
    func minusMonth(_ date: Date) -> Date {
        print("mmm")
        print(date.addingTimeInterval(-30 * 60 * 60 * 24))
        return date.addingTimeInterval(-30 * 60 * 60 * 24)
    }
    
    func daysInMonth(_ date: Date) -> Int {
        let range = calendar.range(of: .day, in: .month, for: date)!
        return range.count
    }
    
    func dayOfMonth(_ date: Date) -> Int {
        let components = calendar.dateComponents([.day], from: date)
        return components.day!
    }
    
    func firstOfMonth(_ date: Date) -> Date {
        let components = calendar.dateComponents([.year, .month], from: date)
        return calendar.date(from: components)!
    }
    
    func weekDay(_ date: Date) -> Int {
        let components = calendar.dateComponents([.weekday], from: date)
        return components.weekday! - 1
    }
    
}
