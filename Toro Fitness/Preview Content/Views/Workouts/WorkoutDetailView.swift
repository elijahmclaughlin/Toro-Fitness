//
//  WorkoutDetailView.swift
//  Toro Fitness
//
//  Created by Elijah McLaughlin on 6/24/24.
//

import SwiftUI

struct WorkoutDetailView: View {
    @EnvironmentObject var workoutManager: WorkoutManager
    @State private var workout: StoreUserWorkoutData
    @State private var exercises: [Exercise] = []
    @State private var newExerciseTitle: String = ""
    @State private var newSetWeight: String = ""
    @State private var newSetReps: String = ""
    @State private var timerRunning = false
    @State private var timeElapsed: TimeInterval = 0
    @State private var timer: Timer?

    init(workout: StoreUserWorkoutData) {
        self._workout = State(initialValue: workout)
    }

    var body: some View {
        VStack {
            TextField("Workout Title", text: workoutTitleBinding)
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

            HStack {
                Button(action: startTimer) {
                    Text("Start Workout")
                        .font(.title)
                        .padding()
                        .background(timerRunning ? Color.gray : Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .disabled(timerRunning)

                Button(action: completeWorkout) {
                    Text("Complete Workout")
                        .font(.title)
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
                .disabled(!timerRunning)
            }

            Text("Time Elapsed: \(timeElapsed, specifier: "%.0f") seconds")
                .padding()
        }
        .navigationTitle("Workout")
        .onAppear {
            if let workoutExercises = workout.relationshipExercise?.allObjects as? [StoreUserExerciseData] {
                exercises = workoutExercises.map { exercise in
                    let sets = (exercise.relationshipSet?.allObjects as? [StoreUserSetData])?.map { set in
                        ExerciseSet(weight: String(set.setWeight), reps: String(set.setReps))
                    } ?? []
                    return Exercise(
                        title: exercise.exerciseTitle ?? "",
                        sets: sets
                    )
                }
            }
        }
    }

    private var workoutTitleBinding: Binding<String> {
        Binding<String>(
            get: { workout.workoutTitle ?? "" },
            set: { workout.workoutTitle = $0 }
        )
    }

    private func addExercise() {
        let newExercise = Exercise(title: newExerciseTitle, sets: [])
        exercises.append(newExercise)
        newExerciseTitle = ""
    }

    private func deleteExercise(at offsets: IndexSet) {
        exercises.remove(atOffsets: offsets)
    }

    private func startTimer() {
        timerRunning = true
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            timeElapsed += 1
        }
    }

    private func completeWorkout() {
        timer?.invalidate()
        timerRunning = false
        timeElapsed = 0
        saveWorkout()
        workoutManager.showWorkoutDetail = false
        // Display congratulatory message (e.g., using an alert or a toast)
    }

    private func saveWorkout() {
        workoutManager.saveWorkout(title: workout.workoutTitle ?? "", exercises: exercises)
    }
}

struct WorkoutDetailView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutDetailView(workout: StoreUserWorkoutData())
            .environmentObject(WorkoutManager(context: PersistenceController.shared.container.viewContext))
    }
}
