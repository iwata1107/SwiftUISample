//
//  CalendarCell.swift
//  CalendarSwiftUI
//
//  Created by Callum Hill on 15/4/22.
//

import SwiftUI

struct CalendarCell: View {
    @EnvironmentObject var dateHolder: DateHolder
    let count : Int
    let startingSpaces : Int
    let daysInMonth : Int
    let daysInPrevMonth : Int
    let prevMonth: Date
    let week: Int
    
    var body: some View {
        Button {
            convDate(type: monthStruct())
        } label: {
            Text(monthStruct().day())
                .foregroundColor(textColor(type: monthStruct()))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
    
    func convDate(type: MonthStruct) {
        let cal = Calendar.current
        let comp_month = cal.dateComponents(
            [Calendar.Component.year, Calendar.Component.month, Calendar.Component.day,
             Calendar.Component.hour, Calendar.Component.minute, Calendar.Component.second],
            from: prevMonth)
        let calendar = Calendar(identifier: .gregorian)
        var dateNum : Date?
        var comp_year = comp_month.year!
        if comp_month.month! == 01 {
            comp_year = comp_month.year! - 1
        }
        if type.monthType == MonthType.Previous {
            dateNum = calendar.date(from: DateComponents(year: comp_year, month: comp_month.month!, day: Int(monthStruct().day())! + 1))
        } else if type.monthType == MonthType.Next {
            dateNum = calendar.date(from: DateComponents(year: comp_year, month: comp_month.month! + 2, day: Int(monthStruct().day())! + 1))
        } else {
            dateNum = calendar.date(from: DateComponents(year: comp_year, month: comp_month.month! + 1, day: Int(monthStruct().day())! + 1))
        }
                
        print(dateNum!)
    }
    
    func textColor(type: MonthStruct) -> Color {
        let cal = Calendar.current
        let comp_month = cal.dateComponents(
            [Calendar.Component.year, Calendar.Component.month, Calendar.Component.day,
             Calendar.Component.hour, Calendar.Component.minute, Calendar.Component.second],
            from: prevMonth)
        let calendar = Calendar(identifier: .gregorian)
        var dateNum : Date?
        var comp_year = comp_month.year!
        if comp_month.month! == 01 {
            comp_year = comp_month.year! - 1
        }
        
        if type.monthType == MonthType.Previous {
            dateNum = calendar.date(from: DateComponents(year: comp_year, month: comp_month.month!, day: Int(monthStruct().day())! + 1))
        } else if type.monthType == MonthType.Next {
            dateNum = calendar.date(from: DateComponents(year: comp_year, month: comp_month.month! + 2, day: Int(monthStruct().day())! + 1))
        } else {
            dateNum = calendar.date(from: DateComponents(year: comp_year, month: comp_month.month! + 1, day: Int(monthStruct().day())! + 1))
        }
        if Date() > dateNum! {
            return Color.green
        }
        else if week == 1 {
            return Color.red
        } else if week == 7 {
            return Color.blue
        }
        else {
            return Color.black
        }
    }
    
    
    func monthStruct() -> MonthStruct {
        let start = startingSpaces == 0 ? startingSpaces + 7 : startingSpaces
        if(count <= start) {
            let day = daysInPrevMonth + count - start
            return MonthStruct(monthType: MonthType.Previous, dayInt: day)
        }
        else if (count - start > daysInMonth) {
            let day = count - start - daysInMonth
            return MonthStruct(monthType: MonthType.Next, dayInt: day)
        }
        
        let day = count - start
        return MonthStruct(monthType: MonthType.Current, dayInt: day)
    }
}

