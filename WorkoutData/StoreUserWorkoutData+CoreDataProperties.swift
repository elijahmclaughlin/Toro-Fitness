//
//  StoreUserWorkoutData+CoreDataProperties.swift
//  Toro Fitness
//
//  Created by Elijah McLaughlin on 6/25/24.
//
//

import Foundation
import CoreData


extension StoreUserWorkoutData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<StoreUserWorkoutData> {
        return NSFetchRequest<StoreUserWorkoutData>(entityName: "StoreUserWorkoutData")
    }

    @NSManaged public var workoutID: Int32
    @NSManaged public var workoutImage: String?
    @NSManaged public var workoutTitle: String?
    @NSManaged public var workoutType: String?
    @NSManaged public var relationshipExercise: NSSet?

}

// MARK: Generated accessors for relationshipExercise
extension StoreUserWorkoutData {

    @objc(addRelationshipExerciseObject:)
    @NSManaged public func addToRelationshipExercise(_ value: StoreUserExerciseData)

    @objc(removeRelationshipExerciseObject:)
    @NSManaged public func removeFromRelationshipExercise(_ value: StoreUserExerciseData)

    @objc(addRelationshipExercise:)
    @NSManaged public func addToRelationshipExercise(_ values: NSSet)

    @objc(removeRelationshipExercise:)
    @NSManaged public func removeFromRelationshipExercise(_ values: NSSet)

}

extension StoreUserWorkoutData : Identifiable {

}
