//
//  MoodscraperApp.swift
//  Moodscraper
//
//  Created by Yaroslav Samoylov on 5/5/23.
//

import SwiftUI

@main
struct MoodscraperApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
