//
//  ballStatsApp.swift
//  ballStats
//
//  Created by Jason Bhan on 1/21/23.
//

import SwiftUI

@main
struct ballStatsApp: App {
    let persistenceController = PersistenceController.shared
    @StateObject var model = ModelData()
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(model)
        }
    }
}
