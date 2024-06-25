//
//  Toro_FitnessApp.swift
//  Toro Fitness
//
//  Created by Elijah McLaughlin on 6/12/24.
//

import SwiftUI

@main
struct Toro_FitnessApp: App {
    let persistenceController = PersistenceController.shared
    
    @StateObject var manager = HealthManager()
    @StateObject var weightManager = WorkoutManager()
    
    var body: some Scene {
        WindowGroup {
            ToroTabView()
                .environmentObject(manager)
                .environmentObject(weightManager)
        }
    }
}
