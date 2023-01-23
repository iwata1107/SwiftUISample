//
//  CoreDataSampleApp.swift
//  CoreDataSample
//
//  Created by 岩田照太 on 2022/02/04.
//

import SwiftUI

@main
struct CoreDataSampleApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
