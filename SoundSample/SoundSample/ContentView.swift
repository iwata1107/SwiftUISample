//
//  ContentView.swift
//  SoundSample
//
//  Created by 岩田照太 on 2021/03/08.
//

import SwiftUI
import AudioToolbox

struct ContentView: View {
    var toDate = Calendar.current.date(byAdding: .hour, value: 2, to: Date())!
    var body: some View {
        VStack{
        Button("sound"){
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
        }
            TimerView(setDate: toDate)
      }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct TimerView: View {
    
    @State var nowDate: Date = Date()
    let setDate: Date
    var timer: Timer {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true){ _ in
            self.nowDate = Date()
        }
    }
    var body: some View {
        Text(TimerFunction(from: setDate))
            .onAppear(perform: {self.timer})
    }
    
    func TimerFunction(from date: Date) -> String {
        let calender = Calendar(identifier: .japanese)
        let timeValue = calender
            .dateComponents([.day, .hour, .minute, .second], from: nowDate, to: setDate)
        return String(format: "残り"+"%02d日:%02d時間%02d分%02d秒",
                      timeValue.day!,
                      timeValue.hour!,
                      timeValue.minute!,
                      timeValue.second!)
    }
}
