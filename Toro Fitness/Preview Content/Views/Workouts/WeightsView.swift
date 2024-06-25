//
//  PersonalView.swift
//  Toro Fitness
//
//  Created by Elijah McLaughlin on 6/12/24.
//

import SwiftUI

struct AddWorkoutView: View {
    @EnvironmentObject var workoutManager: WorkoutManager
    @Binding var isPresented: Bool
    @State private var workoutTitle: String = ""
    @State private var exercises: [Exercise] = []
    @State private var newExerciseTitle: String = ""
    @State private var newSetWeight: String = ""
    @State private var newSetReps: String = ""

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
                            
                            ForEach($exercise.sets) { $set in
                                HStack {
                                    TextField("Weight", text: $set.weight)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                    TextField("Reps", text: $set.reps)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                    Button(action: {
                                        if let index = exercise.sets.firstIndex(where: { $0.id == set.id }) {
                                            exercise.sets.remove(at: index)
                                        }
                                    }) {
                                        Image(systemName: "minus.circle.fill")
                                            .foregroundColor(.red)
                                    }
                                }
                            }
                            .onDelete { indexSet in
                                exercise.sets.remove(atOffsets: indexSet)
                            }

                            HStack {
                                TextField("Weight", text: $newSetWeight)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                TextField("Reps", text: $newSetReps)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())

                                Button(action: {
                                    let newSet = ExerciseSet(weight: newSetWeight, reps: newSetReps)
                                    exercise.sets.append(newSet)
                                    newSetWeight = ""
                                    newSetReps = ""
                                }) {
                                    Image(systemName: "plus.circle.fill")
                                        .foregroundColor(.green)
                                }
                            }
                        }
                    }
                    .onDelete(perform: deleteExercise)

                    HStack {
                        TextField("Exercise Title", text: $newExerciseTitle)

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
        let newExercise = Exercise(title: newExerciseTitle, sets: [])
        exercises.append(newExercise)
        newExerciseTitle = ""
    }

    private func deleteExercise(at offsets: IndexSet) {
        exercises.remove(atOffsets: offsets)
    }

    private func saveWorkout() {
        workoutManager.createNewWorkout(title: workoutTitle, exercises: exercises)
        isPresented = false
    }
}

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

struct AddWorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        AddWorkoutView(isPresented: .constant(true))
            .environmentObject(WorkoutManager(context: PersistenceController.shared.container.viewContext))
    }
}
