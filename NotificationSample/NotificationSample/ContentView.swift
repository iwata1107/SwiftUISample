//
//  ContentView.swift
//  NotificationSample
//
//  Created by 岩田照太 on 2021/03/12.
//
import SwiftUI
import  UserNotifications

struct ContentView: View {
    //@State var buttonText = "5秒後にローカル通知を発行する"
    @State var wakeup = Date()
    /*
    //通知関係メソッド
    func makeNotification(){
        //通知タイミングを指定
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        //通知コンテンツの作成
        let content = UNMutableNotificationContent()
        content.title = "ローカル通知"
        content.body = "ローカル通知です"
        content.sound = UNNotificationSound.default
        
        //通知リクエストを作成
        let request = UNNotificationRequest(identifier: "notification001", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    */
    func scheduleNotification() -> Void {
        print("aa")
        let content = UNMutableNotificationContent()
        content.title = "Your title"
        content.body = "Your body"
        content.sound = UNNotificationSound.default
        
        var reminderDate = wakeup
        
        if reminderDate < Date() {
            if let addedValue = Calendar.current.date(byAdding: .day, value: 1, to: reminderDate) {
                reminderDate = addedValue
            }
        }

        let comps = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: reminderDate)
                               
        let trigger = UNCalendarNotificationTrigger(dateMatching: comps, repeats: true)
        
        let request = UNNotificationRequest(identifier: "alertNotificationUnique", content: content, trigger: trigger)

         UNUserNotificationCenter.current().add(request) {(error) in
             if let error = error {
                 print("Uh oh! We had an error: \(error)")
             }
         }
    }
    
    func requestPush() -> Void {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                print("All set!")
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }

    var body: some View {
        /*
        //ローカル通知発行ボタン
        Button(action: {
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound,.badge]){
                (granted, error) in
                if granted {
                    //通知が許可されている場合の処理
                    makeNotification()
                }else {
                    //通知が拒否されている場合の処理
                    //ボタンの表示を変える
                    buttonText = "通知が拒否されているので発動できません"
                    //1秒後に表示を戻す
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    buttonText = "5秒後にローカル通知を発行する"
                    }
                }
            }
        }) {
            //ボタンのテキストを表示
            Text(buttonText)
        }
        */
        VStack {
        
       
            Button(action: {
                scheduleNotification()
            }) {
                Text("Save notification")
            }
            
             DatePicker("Select a time ",
                        selection: $wakeup, displayedComponents: [.date,.hourAndMinute])
                 .font(.title2)
                 .accentColor(Color(.white))
        }
        .frame(width: 300, height: 20, alignment: .center)
        .padding()

    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
