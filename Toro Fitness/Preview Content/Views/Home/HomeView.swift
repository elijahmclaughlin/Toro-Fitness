//
//  HomeView.swift
//  Toro Fitness
//
//  Created by Elijah McLaughlin on 6/12/24.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var manager: HealthManager
    var body: some View {
        VStack(alignment: .leading) {
            Text("Hub")
                .font(.largeTitle)
                .bold()
                .padding(.top)
                .padding()
            
            LazyVGrid(columns: Array(repeating: GridItem(spacing: 20), count: 1)) {
                ForEach(manager.activities.sorted(by: { $0.value.id < $1.value.id}), id:\.key) { item in ActivityCard(activity: item.value)
                    }
                }
            
            .padding(.horizontal)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(HealthManager())
    }
}
