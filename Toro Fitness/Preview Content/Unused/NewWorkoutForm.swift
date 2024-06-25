//
//  NewWorkoutForm.swift
//  Toro Fitness
//
//  Created by Elijah McLaughlin on 6/24/24.
//
//
//import SwiftUI
//
//struct NewWorkoutForm: View {
//    @EnvironmentObject var workoutManager: WorkoutManager
//    @State private var title: String = ""
//
//    var body: some View {
//        NavigationView {
//            Form {
//                Section(header: Text("Workout Details")) {
//                    TextField("Workout Title", text: $title)
//                }
//                
//                Button(action: {
//                    workoutManager.createNewWorkout(title: title)
//                    workoutManager.showNewWorkoutForm = false
//                }) {
//                    Text("Save")
//                        .font(.headline)
//                        .padding()
//                        .background(Color.green)
//                        .foregroundColor(.white)
//                        .cornerRadius(10)
//                }
//            }
//            .navigationBarTitle("New Workout", displayMode: .inline)
//            .navigationBarItems(trailing: Button(action: {
//                workoutManager.showNewWorkoutForm = false
//            }) {
//                Image(systemName: "xmark")
//                    .foregroundColor(.red)
//            })
//        }
//    }
//}
//
//struct NewWorkoutForm_Previews: PreviewProvider {
//    static var previews: some View {
//        NewWorkoutForm()
//            .environmentObject(WorkoutManager())
//    }
//}
