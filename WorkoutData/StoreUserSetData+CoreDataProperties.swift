//
//  StoreUserSetData+CoreDataProperties.swift
//  Toro Fitness
//
//  Created by Elijah McLaughlin on 6/25/24.
//
//

import Foundation
import CoreData

extension StoreUserSetData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<StoreUserSetData> {
        return NSFetchRequest<StoreUserSetData>(entityName: "StoreUserSetData")
    }

    @NSManaged public var setID: UUID?
    @NSManaged public var setWeight: Int16
    @NSManaged public var setReps: Int16
    @NSManaged public var relationshipExercise: StoreUserExerciseData?

}

extension StoreUserSetData : Identifiable {

}

