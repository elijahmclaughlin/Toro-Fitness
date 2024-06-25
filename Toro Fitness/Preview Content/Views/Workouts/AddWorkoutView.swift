//
//  AddWorkoutView.swift
//  Toro Fitness
//
//  Created by Elijah McLaughlin on 6/25/24.
//

import SwiftUI

struct Exercise: Identifiable {
    let id = UUID()
    var title: String
    var sets: [ExerciseSet]
}

struct ExerciseSet: Identifiable {
    let id = UUID()
    var weight: String
    var reps: String
}

struct AddWorkoutView: View {
    @EnvironmentObject var workoutManager: WorkoutManager
    @Binding var isPresented: Bool
    @State private var workoutTitle: String = ""
    @State private var exercises: [Exercise] = []
    @State private var newExerciseTitle: String = ""
    @State private var weight: String = ""
    @State private var reps: String = ""

    var body: some View {
        NavigationView {
            VStack {
                TextField("Workout Title", text: $workoutTitle)
                    .font(.largeTitle)
                    .padding()

                List {
                    ForEach($exercises) { $exercise in
                        VStack(alignment: .leading) {
                            TextField("Exercise Title", text: $exercise.title)
                            HStack {
                                TextField("Weight", text: $exercise.weight)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                TextField("Reps", text: $exercise.reps)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                            }
                        }
                    }
                    .onDelete(perform: deleteExercise)

                    HStack {
                        TextField("Exercise", text: $newExerciseTitle)
                        TextField("Weight", text: $weight)
                            .keyboardType(.decimalPad)
                        TextField("Reps", text: $reps)
                            .keyboardType(.numberPad)

                        Button(action: addExercise) {
                            Image(systemName: "plus.circle.fill")
                                .foregroundColor(.green)
                        }
                    }
                }

                Button(action: saveWorkout) {
                    Text("Save Workout")
                        .font(.title)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
            }
            .navigationTitle("Add New Workout")
        }
    }

    private func addExercise() {
        let newExercise = Exercise(title: newExerciseTitle, weight: weight, reps: reps)
        exercises.append(newExercise)
        newExerciseTitle = ""
        weight = ""
        reps = ""
    }

    private func deleteExercise(at offsets: IndexSet) {
        exercises.remove(atOffsets: offsets)
    }

    private func saveWorkout() {
        workoutManager.createNewWorkout(title: workoutTitle, exercises: exercises)
        isPresented = false
    }
}

struct AddWorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        AddWorkoutView(isPresented: .constant(true))
            .environmentObject(WorkoutManager(context: PersistenceController.shared.container.viewContext))
    }
}

