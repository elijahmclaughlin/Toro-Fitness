//
//  WorkoutView.swift
//  Toro Fitness
//
//  Created by Elijah McLaughlin on 6/25/24.
//
//
//import Foundation
//import SwiftUI
//
//struct WorkoutView: View {
//    @EnvironmentObject var workoutManager: WorkoutManager
//    @State private var workout: StoreUserWorkoutData
//
//    init(workout: StoreUserWorkoutData) {
//        self._workout = State(initialValue: workout)
//    }
//
//    var body: some View {
//        VStack {
//            Text(workout.workoutTitle ?? "Workout")
//                .font(.largeTitle)
//                .bold()
//                .padding()
//
//            List {
//                ForEach(workout.relationshipExercise?.allObjects as? [StoreUserExerciseData] ?? [], id: \.self) { exercise in
//                    ExerciseView(exercise: exercise)
//                }
//                .onDelete(perform: deleteExercise)
//                
//                Button(action: addExercise) {
//                    Text("Add Exercise")
//                }
//            }
//        }
//        .navigationBarItems(trailing: Button(action: saveWorkout) {
//            Text("Save")
//        })
//    }
//
//    private func addExercise() {
//        let newExercise = StoreUserExerciseData(context: workoutManager.viewContext)
//        newExercise.exerciseID = UUID()
//        newExercise.exerciseTitle = "New Exercise"
//        newExercise.relationshipWorkout = workout
//        workout.addToRelationshipExercise(newExercise)
//        workoutManager.saveContext()
//    }
//
//    private func deleteExercise(at offsets: IndexSet) {
//        if let exercises = workout.relationshipExercise?.allObjects as? [StoreUserExerciseData] {
//            for index in offsets {
//                let exercise = exercises[index]
//                workoutManager.viewContext.delete(exercise)
//            }
//            workoutManager.saveContext()
//        }
//    }
//
//    private func saveWorkout() {
//        workoutManager.saveContext()
//    }
//}
//
//struct WorkoutView_Previews: PreviewProvider {
//    static var previews: some View {
//        WorkoutView(workout: StoreUserWorkoutData())
//            .environmentObject(WorkoutManager(context: PersistenceController.shared.container.viewContext))
//    }
//}
