//
//  ActivityCard.swift
//  Toro Fitness
//
//  Created by Elijah McLaughlin on 6/13/24.
//

import SwiftUI

extension Color {
    static let customPink = Color(red: 223 / 255, green: 0 / 255, blue: 107 / 255)
}

struct Activity {
    let id: Int
    let title: String
    let subtitle: String
    let image: String
    let amount: String
}

struct ActivityCard: View {
    @State var activity: Activity
    var body: some View {
        ZStack {
            Color.gray
                .cornerRadius(15)
                .opacity(0.3)
                .blur(radius: 2)
            
            VStack(spacing: 20) {
                HStack(alignment: .center) {
                    VStack(alignment: .leading, spacing: 5) {
                        Text(activity.title).bold()
                            .font(.system(size: 16))
                        
                        Text(activity.subtitle)
                            .font(.system(size: 12))
                    }
                    
                    Spacer()
                    
                    Text(activity.amount)
                        .font(.system(size: 24))
                        .frame(alignment: .center)
                    
                    Spacer()
                    
                    Image(systemName: activity.image)
                        .foregroundColor(.customPink)
                        .scaleEffect(1.5)
                        .frame(alignment: .center)
                }
                .padding()
            }
            .padding()
        .cornerRadius(15)
        }
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color.customPink.opacity(0.5), lineWidth: 2)
        )
    }
}

#Preview {
    ActivityCard(activity: Activity(id: 0, title: "Steps", subtitle: "Today", image: "figure.walk", amount: "10,000"))
}
