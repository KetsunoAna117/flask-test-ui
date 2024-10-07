//
//  Flask_Test_UIApp.swift
//  Flask-Test-UI
//
//  Created by Hans Arthur Cupiterson on 29/09/24.
//

import SwiftUI
import TipKit

@main
struct Flask_Test_UIApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .task {
                    try? Tips.configure([
//                        .displayFrequency(.hourly),
                        .datastoreLocation(.applicationDefault)
                    ])
                }
        }
    }
}
