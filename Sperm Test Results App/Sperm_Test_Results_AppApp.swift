//
//  Sperm_Test_Results_AppApp.swift
//  Sperm Test Results App
//
//  Created by Work Laptop on 10/04/2025.
//

import FirebaseCore
import SwiftUI
@main
struct Sperm_Test_Results_AppApp: App {
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
