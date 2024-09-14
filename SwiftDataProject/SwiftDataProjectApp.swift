//
//  SwiftDataProjectApp.swift
//  SwiftDataProject
//
//  Created by Naveed on 09/09/2024.
//

import SwiftUI
import SwiftData

@main
struct SwiftDataProjectApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}
