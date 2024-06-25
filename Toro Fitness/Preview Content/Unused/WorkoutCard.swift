//
//  WorkoutCard.swift
//  Toro Fitness
//
//  Created by Elijah McLaughlin on 6/18/24.
//

//import SwiftUI
//
//struct Workout {
//    let id: Int
//    let title: String
//    let image: String
//}
//
//struct WorkoutCard: View {
//    @State var activity: Workout
//    @EnvironmentObject var workoutManager: WorkoutManager
//
//    var body: some View {
//        Button(action: {
//            if let selectedWorkout = workoutManager.fetchWorkout(byID: Int32(activity.id)) {
//                workoutManager.selectedWorkout = selectedWorkout
//                workoutManager.showWorkoutDetail = true
//            }
//        }) {
//            ZStack {
//                Color.gray
//                    .cornerRadius(15)
//                    .opacity(0.3)
//                    .blur(radius: 2)
//
//                VStack(spacing: 20) {
//                    HStack(alignment: .center) {
//                        VStack(alignment: .leading, spacing: 5) {
//                            Text(activity.title).bold()
//                                .font(.system(size: 16))
//                        }
//
//                        Spacer()
//
//                        Image(systemName: activity.image)
//                            .foregroundColor(.customPink)
//                            .scaleEffect(1.5)
//                            .frame(alignment: .center)
//                    }
//                    .padding()
//                }
//                .padding()
//            }
//            .cornerRadius(15)
//            .overlay(
//                RoundedRectangle(cornerRadius: 15)
//                    .stroke(Color.customPink.opacity(0.5), lineWidth: 2)
//            )
//        }
//    }
//}
//
//struct WorkoutCard_Previews: PreviewProvider {
//    static var previews: some View {
//        WorkoutCard(activity: Workout(id: 0, title: "Custom Workout", image: "dumbbell")) // Use the static image here
//            .environmentObject(WorkoutManager())
//    }
//}
