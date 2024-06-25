//
//  HealthManager.swift
//  Toro Fitness
//
//  Created by Elijah McLaughlin on 6/13/24.
//

import Foundation
import HealthKit

extension Date {
    static var startOfDay: Date {
        Calendar.current.startOfDay(for: Date())
    }
}

class HealthManager: ObservableObject {
    
    let healthStore = HKHealthStore()
    
    @Published var activities: [String : Activity] = [:]
    
    @Published var mockActivities: [String : Activity] = [
        "todaySteps" : Activity(id: 0, title: "Steps", subtitle: "Today", image: "figure.walk", amount: "0"),
        "todaysCals" : Activity(id: 1, title: "Calories Burned", subtitle: "Today", image: "flame.fill", amount: "0")
    ]
    
    init() {
        let steps = HKQuantityType(.stepCount)
        let calories = HKQuantityType(.activeEnergyBurned)
        let basal = HKQuantityType(.basalEnergyBurned)
        
        let healthTypes: Set = [steps, calories, basal]
        
        Task {
            do {
                try await healthStore.requestAuthorization(toShare: [], read: healthTypes)
                fetchTodaySteps()
                fetchTodayActCalories()
                fetchTodayRestCalories()
            } catch {
                print("error fetching health data")
            }
        }
    }
    
    func fetchTodaySteps() {
        let steps = HKQuantityType(.stepCount)
        let predicate = HKQuery.predicateForSamples(withStart: .startOfDay, end: Date())
        let query = HKStatisticsQuery(quantityType: steps, quantitySamplePredicate: predicate) { _, result, error in
            guard let quantity = result?.sumQuantity(), error == nil else {
                print("error fetching todays step data")
                return
            }
            let stepCount = quantity.doubleValue(for: .count())
            let activity = Activity(id: 0, title: "Steps", subtitle: "Today", image: "figure.walk", amount: stepCount.formattedString())
            
            DispatchQueue.main.async {
                self.activities["todaySteps"] = activity
            }
            
            print(stepCount.formattedString())
        }
        
        healthStore.execute(query)
    }
    
    func fetchTodayActCalories() {
        let calories = HKQuantityType(.activeEnergyBurned)
        let predicate = HKQuery.predicateForSamples(withStart: .startOfDay, end: Date())
        let query = HKStatisticsQuery(quantityType: calories, quantitySamplePredicate: predicate) { _, result, error in
            guard let quantity = result?.sumQuantity(), error == nil else {
                print("error fetching todays active calorie data")
                return
            }
            let calsBurned = quantity.doubleValue(for: .kilocalorie())
            let activity = Activity(id: 1, title: "Active Calories", subtitle: "Today", image: "flame.fill", amount: calsBurned.formattedString())
            
            DispatchQueue.main.async {
                self.activities["todaysCals"] = activity
            }
            
            print(calsBurned.formattedString())
        }
        healthStore.execute(query)
    }
        
    func fetchTodayRestCalories() {
        let basal = HKQuantityType(.basalEnergyBurned)
        let predicate = HKQuery.predicateForSamples(withStart: .startOfDay, end: Date())
        let query = HKStatisticsQuery(quantityType: basal, quantitySamplePredicate: predicate) { _, result, error in
            guard let quantity = result?.sumQuantity(), error == nil else {
                print("error fetching todays basal calorie data")
                return
            }
            let basalBurned = quantity.doubleValue(for: .kilocalorie())
            let activity = Activity(id: 2, title: "Basal Calories", subtitle: "Today", image: "flame", amount: basalBurned.formattedString())
            
            DispatchQueue.main.async {
                self.activities["todaysBCals"] = activity
            }
            
            print(basalBurned.formattedString())
        }
        healthStore.execute(query)
    }
    
}

extension Double {
    func formattedString() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 0
        
        return numberFormatter.string(from: NSNumber(value: self))!
    }
}
