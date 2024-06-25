//
//  ToroTabView.swift
//  Toro Fitness
//
//  Created by Elijah McLaughlin on 6/12/24.
//

import SwiftUI

extension Color {
    static let customLightPink = Color(red: 220 / 255, green: 84 / 255, blue: 157 / 255)
}

struct ToroTabView: View {
    @EnvironmentObject var manager: HealthManager
    @EnvironmentObject var weightManager: WorkoutManager
    @State var selectedTab = "Home"
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tag("Home")
                .tabItem {
                    Image(systemName: "house")
                        .foregroundColor(selectedTab == "Home" ? .customPink : .customLightPink)
                    Text("Home")
                }
                .environmentObject(manager)
            
            WeightsView()
                .tag("Weights")
                .tabItem {
                    Image(systemName: "dumbbell")
                        .foregroundColor(selectedTab == "Weights" ? .customPink : .customLightPink)
                    Text("Weights")
                }
                .environmentObject(weightManager)
            
            MealsView()
                .tag("Meals")
                .tabItem {
                    Image(systemName: "fork.knife")
                        .foregroundColor(selectedTab == "Meals" ? .customPink : .customLightPink)
                    Text("Meals")
                }
        }
        .accentColor(.customPink)
    }
}

struct ToroTabView_Previews: PreviewProvider {
    static var previews: some View {
        ToroTabView()
            .environmentObject(HealthManager())
            .environmentObject(WorkoutManager(context: PersistenceController.shared.container.viewContext))
    }
}
