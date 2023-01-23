//
//  ContentView.swift
//  CSVSample
//
//  Created by 岩田照太 on 2021/04/01.
//

import SwiftUI
import Foundation


struct ContentView: View {
    
    @State var csvArr = [String]()
    @State var fluits = [String]()
    @State var flu = [String]()
    @State var WordBook:Dictionary<String,String> = [:]
    @State var selection:String = ""
    @State var showPicker = false
    
    var body: some View {
        VStack{
            Button(action:{
                
                showPicker = true
                
            }) {
                Text("Load CSV")
            }
            
            Text("\(selection)").foregroundColor(.red)
            Text("\(WordBook[selection] ?? "")")
                
            
            if showPicker {
                SinglePicker(fluits: fluits, selection: $selection)
            } else {
                SinglePicker(fluits: fluits, selection: $selection)
            }
            
            
        }
        .onAppear {
            guard let fileURL = Bundle.main.url(forResource: "brand", withExtension: "csv") else {
                fatalError("ファイルが見つからない")
            }
            /// 2.ファイルの読み込み
            guard let fileContents = try? String(contentsOf: fileURL) else {
                fatalError("ファイルの読み込みができません")
            }
            /// 3.ファイルの出力
            //print(fileContents)
            //print(fileContents.components(separatedBy: "\n"))
            var x = fileContents.components(separatedBy: "\n")
            var brands = [String]()
            for i in 0..<x.count {
                x[i].removeAll(where: { $0 == "/" }) //iからcharを削除
                //x[i].removeAll(where: { $0 == " " }) //iからcharを削除
                
                brands.append(x[i])
            }
            let str = "あいうeo"
            str.replacingOccurrences(of: "eo", with: "えお")
            print(str)
            print(brands[0].trimmingCharacters(in: .whitespaces))
        }
//        .onAppear(
//            perform: {
//                let url = Bundle.main.path(forResource: "brand", ofType: "csv")
//
//                do {
//
//                    let csvString = try String(contentsOfFile: url!, encoding: String.Encoding.utf8)
//
//                    csvArr = csvString.components(separatedBy: .newlines)
//                    csvArr.removeLast()
//
//                    var count = 0
//
//                    for sstr in csvArr  {
//                        count += 1
//                        let arrayPart:[String] = sstr.components(separatedBy: "\n")
//
//                        if(count != csvArr.count){
//                        fluits.append(arrayPart[0])
//                            flu.append(arrayPart[1])
//                            WordBook[arrayPart[0]] = arrayPart[1]
//                        }
//                    }
//                } catch let error as NSError {
//                    print("Error: \(error)")
//                    return
//                }
//
//
//            }
//        )
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct SinglePicker: View {
    let fluits: [String]
    @Binding var selection:String
    
    var body: some View {
        GeometryReader { geometry in
            Picker(" WordBook", selection: $selection) {
                ForEach(0..<fluits.count) { row in
                    Text(verbatim: fluits[row]).tag(fluits[row])
                }
            }
        }
    }
}

