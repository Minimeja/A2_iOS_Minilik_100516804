//
//  A2_iOS_Minilik_100516804App.swift
//  A2_iOS_Minilik_100516804
//
//  Created by Minilik Meja on 2026-04-06.
//

import SwiftUI
import CoreData

@main
struct A2_iOS_Minilik_100516804App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
        HomeView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
