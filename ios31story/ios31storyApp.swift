//
//  ios31storyApp.swift
//  ios31story
//
//  Created by Yaroslav Samoylov on 5/23/23.
//

import SwiftUI

@main
struct ios31storyApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
