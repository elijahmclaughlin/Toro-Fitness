//
//  StoreUserExerciseData+CoreDataProperties.swift
//  Toro Fitness
//
//  Created by Elijah McLaughlin on 6/25/24.
//
//

import Foundation
import CoreData

extension StoreUserExerciseData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<StoreUserExerciseData> {
        return NSFetchRequest<StoreUserExerciseData>(entityName: "StoreUserExerciseData")
    }

    @NSManaged public var exerciseID: UUID?
    @NSManaged public var exerciseTitle: String?
    @NSManaged public var relationshipSet: NSSet?
    @NSManaged public var relationshipWorkout: StoreUserWorkoutData?

}

// MARK: Generated accessors for relationshipSet
extension StoreUserExerciseData {

    @objc(addRelationshipSetObject:)
    @NSManaged public func addToRelationshipSet(_ value: StoreUserSetData)

    @objc(removeRelationshipSetObject:)
    @NSManaged public func removeFromRelationshipSet(_ value: StoreUserSetData)

    @objc(addRelationshipSet:)
    @NSManaged public func addToRelationshipSet(_ values: NSSet)

    @objc(removeRelationshipSet:)
    @NSManaged public func removeFromRelationshipSet(_ values: NSSet)

}

extension StoreUserExerciseData : Identifiable {

}
