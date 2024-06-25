//
//  WorkoutManager.swift
//  Toro Fitness
//
//  Created by Elijah McLaughlin on 6/18/24.
//

import Foundation
import CoreData
import SwiftUI

class WorkoutManager: ObservableObject {
    @Published var workouts: [StoreUserWorkoutData] = []
    @Published var selectedWorkout: StoreUserWorkoutData? = nil
    @Published var showWorkoutDetail: Bool = false
    @Published var showNewWorkoutForm: Bool = false

    private(set) var viewContext: NSManagedObjectContext

    init(context: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        self.viewContext = context
        fetchWorkouts()
    }

    func fetchWorkouts() {
        let request: NSFetchRequest<StoreUserWorkoutData> = StoreUserWorkoutData.fetchRequest()
        do {
            workouts = try viewContext.fetch(request)
        } catch {
            print("Error fetching workouts: \(error)")
        }
    }

    func fetchWorkout(byID id: Int32) -> StoreUserWorkoutData? {
        let request: NSFetchRequest<StoreUserWorkoutData> = StoreUserWorkoutData.fetchRequest()
        request.predicate = NSPredicate(format: "workoutID == %d", id)
        request.fetchLimit = 1

        do {
            return try viewContext.fetch(request).first
        } catch {
            print("Error fetching workout by ID: \(error)")
            return nil
        }
    }

    func createNewWorkout(title: String, exercises: [Exercise]) {
        DispatchQueue.main.async {
            let newWorkout = StoreUserWorkoutData(context: self.viewContext)
            newWorkout.workoutID = Int32(self.workouts.count + 1)
            newWorkout.workoutTitle = title
            newWorkout.workoutImage = "dumbbell" // Set the static image here

            for exercise in exercises {
                let newExercise = StoreUserExerciseData(context: self.viewContext)
                newExercise.exerciseID = UUID()
                newExercise.exerciseTitle = exercise.title
                newExercise.relationshipWorkout = newWorkout

                for set in exercise.sets {
                    let newSet = StoreUserSetData(context: self.viewContext)
                    newSet.setID = UUID()
                    newSet.setWeight = Int16(set.weight) ?? 0 // Convert weight to Int16
                    newSet.setReps = Int16(set.reps) ?? 0 // Convert reps to Int16
                    newSet.relationshipExercise = newExercise
                    newExercise.addToRelationshipSet(newSet)
                }

                newWorkout.addToRelationshipExercise(newExercise)
            }

            self.saveContext()
            self.fetchWorkouts()
            self.selectedWorkout = newWorkout
        }
    }

    func saveWorkout(title: String, exercises: [Exercise]) {
        guard let selectedWorkout = selectedWorkout else { return }
        selectedWorkout.workoutTitle = title

        // Clear existing exercises
        if let existingExercises = selectedWorkout.relationshipExercise as? Set<StoreUserExerciseData> {
            for exercise in existingExercises {
                viewContext.delete(exercise)
            }
        }

        // Add new exercises and sets
        for exercise in exercises {
            let newExercise = StoreUserExerciseData(context: viewContext)
            newExercise.exerciseID = UUID()
            newExercise.exerciseTitle = exercise.title
            newExercise.relationshipWorkout = selectedWorkout

            for set in exercise.sets {
                let newSet = StoreUserSetData(context: viewContext)
                newSet.setID = UUID()
                newSet.setWeight = Int16(set.weight) ?? 0 // Convert weight to Int16
                newSet.setReps = Int16(set.reps) ?? 0 // Convert reps to Int16
                newSet.relationshipExercise = newExercise
                newExercise.addToRelationshipSet(newSet)
            }

            selectedWorkout.addToRelationshipExercise(newExercise)
        }

        saveContext()
        fetchWorkouts()
    }

    func saveContext() {
        do {
            try viewContext.save()
        } catch {
            print("Error saving context: \(error)")
        }
    }
}
