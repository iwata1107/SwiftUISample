//
//  ChartViewSampleApp.swift
//  ChartViewSample
//
//  Created by 岩田照太 on 2021/04/21.
//

import SwiftUI

@main
struct ChartViewSampleApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

struct ChatMessage: Identifiable {
    
    var id: String { documentId }
    
    let documentId: String
    let fromId, toId, text: String
    
    init(documentId: String, data: [String: Any]) {
        self.documentId = documentId
        self.fromId = ""//data[FirebaseConstants.fromId] as? String ?? ""
        self.toId = ""//data[FirebaseConstants.toId] as? String ?? ""
        self.text = ""//data[FirebaseConstants.text] as? String ?? ""
    }
}

