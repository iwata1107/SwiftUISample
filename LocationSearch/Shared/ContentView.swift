//
//  ContentView.swift
//  Shared
//
//  Created by Balaji on 20/04/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView{
            VStack {
                NavigationLink {
                    SearchView()
                       // .navigationBarHidden(true)
                } label: {
                    Text("Search")
                }
                NavigationLink {
                    Sample1View()
                        //.navigationBarHidden(true)
                } label: {
                    Text("Sample1")
                }
                NavigationLink {
                    Sample2()
                        //.navigationBarHidden(true)
                } label: {
                    Text("Sample2")
                }
                
            }
           
        }.navigationViewStyle(.stack)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

