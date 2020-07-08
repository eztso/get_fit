//
//  HealthData.swift
//  Get Fit
//
//  Created by Ewin Zuo on 7/4/20.
//  Copyright © 2020 Ewin Zuo. All rights reserved.
//

//
//  HealthData.swift
//  ZuoEwin-HW8
//
//  Created by Ewin Zuo on 7/4/20.
//  Copyright © 2020 Ewin Zuo. All rights reserved.
//
import HealthKit
import Foundation

struct Constant{
    static var healthdata = HealthData()
    let recCalories = 2500
    
}
class HealthData {
    var healthStore: HKHealthStore
    var caloriesBurned: Double? = 0
    var foodCalories: Double? = 0
    var foodProtein: Double? = 0
    var foodFat: Double? = 0
    var foodSugar:Double? = 0
    var stepsTaken: Double? = 0
    
    let permissions = Set([HKObjectType.workoutType(),
                           HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!,
                           HKObjectType.quantityType(forIdentifier: .stepCount)!,
                           HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)!,
                           HKObjectType.quantityType(forIdentifier: .heartRate)!])
    
    
    
    init() {
        // Add code to use HealthKit here.
        healthStore = HKHealthStore()
        healthStore.requestAuthorization(toShare: permissions, read: permissions) { (success, error) in

        }
        
    }

    
    func getTodaysSteps(completion: @escaping (Double) -> Void) {
        let stepsQuantityType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
        
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)
        
        let query = HKStatisticsQuery(quantityType: stepsQuantityType, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, result, _ in
            guard let result = result, let sum = result.sumQuantity() else {
                completion(0.0)
                return
            }
            completion(sum.doubleValue(for: HKUnit.count()))
        }
        
        healthStore.execute(query)
    }
    
    func getTodaysMiles(completion: @escaping (Double) -> Void) {
        let milesQuantityType = HKQuantityType.quantityType(forIdentifier: .distanceWalkingRunning)!
        
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)
        
        let query = HKStatisticsQuery(quantityType: milesQuantityType, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, result, _ in
            guard let result = result, let sum = result.sumQuantity() else {
                completion(0.0)
                return
            }
            completion(sum.doubleValue(for: HKUnit.mile()))
        }
        
        healthStore.execute(query)
    }
    func setTodaysSteps(steps: Double) {
        let stepsQuantityType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
        
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        
        let s = HKQuantitySample.init(type: stepsQuantityType,
                                          quantity: HKQuantity.init(unit: HKUnit.count(), doubleValue: steps),
                                          start: startOfDay,
                                          end: now)
        
        healthStore.save(s) { success, error in
            if (error != nil) {
                print("Error: \(String(describing: error))")
            }
            if success {
                print("Saved: \(success)")
            }
        }
    }
    func setTodaysMiles(miles: Double) {
        let milesQuantityType = HKQuantityType.quantityType(forIdentifier: .distanceWalkingRunning)!
        
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        
        let m = HKQuantitySample.init(type: milesQuantityType,
                                          quantity: HKQuantity.init(unit: HKUnit.mile(), doubleValue: miles),
                                          start: startOfDay,
                                          end: now)
        healthStore.save(m) { success, error in
            if (error != nil) {
                print("Error: \(String(describing: error))")
            }
            if success {
                print("Saved: \(success)")
            }
        }
    }
}


