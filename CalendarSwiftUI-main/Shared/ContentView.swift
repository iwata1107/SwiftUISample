//
//  ContentView.swift
//  Shared
//
//  Created by Callum Hill on 15/4/22.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var dateHolder: DateHolder
    var body: some View {
        VStack(spacing: 1) {
            DateScrollerView()
                .environmentObject(dateHolder)
                .padding()
            dayOfWeekStack
            calendarGrid
            
        }
    }
    
    var dayOfWeekStack: some View {
        HStack(spacing: 1) {
            Text("日").dayOfWeek()
            Text("月").dayOfWeek()
            Text("火").dayOfWeek()
            Text("水").dayOfWeek()
            Text("木").dayOfWeek()
            Text("金").dayOfWeek()
            Text("土").dayOfWeek()
        }
    }
    
    var calendarGrid: some View {
        VStack(spacing: 1) {
            let daysInMonth = CalendarHelper().daysInMonth(dateHolder.date)
            let firstDayOfMonth = CalendarHelper().firstOfMonth(dateHolder.date)
            let startingSpaces = CalendarHelper().weekDay(firstDayOfMonth)
            let prevMonth = CalendarHelper().minusMonth(dateHolder.date)
            let daysInPrevMonth = CalendarHelper().daysInMonth(prevMonth)
            
            ForEach(0..<6) { row in
                HStack(spacing: 1) {
                    ForEach(1..<8) { column in
                        let count = column + (row * 7)
                        CalendarCell(count: count, startingSpaces:startingSpaces, daysInMonth: daysInMonth, daysInPrevMonth: daysInPrevMonth, prevMonth: prevMonth, week: column)
                            .environmentObject(dateHolder)
                        
                    }
                }
            }
        }
        .frame(maxHeight: .infinity)
    }
}


extension Text {
    func dayOfWeek() -> some View {
        self.frame(maxWidth: .infinity)
            .padding(.top, 1)
            .lineLimit(1)
    }
}
