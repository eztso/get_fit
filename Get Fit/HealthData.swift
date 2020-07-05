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
}
class HealthData {
    var healthStore: HKHealthStore
    var caloriesBurned: Double?
    var foodCalories: Double?
    var foodProtein: Double?
    var foodFat: Double?
    var foodSugar:Double?
    var stepsTaken: Double?
    let permissions = Set([HKObjectType.workoutType(),
    HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!,
    HKObjectType.quantityType(forIdentifier: .stepCount)!,
    HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)!,
    HKObjectType.quantityType(forIdentifier: .heartRate)!])
    
    

    init() {
            // Add code to use HealthKit here.
            healthStore = HKHealthStore()
       healthStore.requestAuthorization(toShare: permissions, read: permissions) { (success, error) in
            if success {
                self.getTodaysSteps(completion: self.setTodaysSteps)

            }
        }

    }
    func setTodaysSteps(steps: Double) {

        self.stepsTaken = steps
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
}


