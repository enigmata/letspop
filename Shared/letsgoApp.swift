//
//  letsgoApp.swift
//  Shared
//
//  Created by Randy Horman on 2023-12-01.
//

import SwiftUI

@main
struct letsgoApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
