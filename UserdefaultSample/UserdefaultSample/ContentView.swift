//
//  ContentView.swift
//  UserdefaultSample
//
//  Created by 岩田照太 on 2021/04/18.
//

import SwiftUI

struct ContentView: View {
    @State var checkData = UserDefaults.standard.array(forKey: "check") as? [String] ?? []
    @State var chinese = [" Japanese Name","東京","ワシントD.C","北京","ニューデリー","ジャカルタ","イスラマバード","ブラジリア","アブジャ","ダッカ","モスクワ"]
    @State var random = 0
    var body: some View {
        VStack{
            Button(action: append){
                Text("append")
            }
            
            Button(action: remove){
                Text("remove")
            }
            
            Button(action: rand){
                Text("random")
            }
        }
    }
    
    func rand() -> Void {
        random = Int.random(in: 0..<11)
        print("random:" + "\(random)")
        print("append:" + "\(checkData[random])")
        var rrr:Int
        
        rrr = random/2
        print(rrr)
    }
    
    func append() -> Void {
        checkData.append(chinese[random])
        UserDefaults.standard.set(checkData, forKey: "check")
        print("append:" + "\(checkData)")
    }
    
    func remove() -> Void {
        checkData.remove(at: random)
        UserDefaults.standard.set(checkData, forKey: chinese[random])
        print("remove:" + "\(checkData)")
        print("random:" + "\(random)")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(random: 0)
    }
}
