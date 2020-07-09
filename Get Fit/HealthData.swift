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
import CoreData
import UIKit



class HealthData {
    var histLength = 90
    var healthStore: HKHealthStore
    var history : History
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
        history = History()
        self.retrieveData();
        
    }
    
    func check() {
        
        if history.dailyHealth.count == 0 {
            history.dailyHealth = [Health](repeating: Health(), count: 90)
        }
    
        let formatter = DateFormatter()
        
        formatter.dateFormat = "yyyy-MM-dd"
        let dateString = formatter.string(from: Date())
        print(dateString)
        
        if history.dailyHealth[0].date != dateString {
            for i in 0..<history.dailyHealth.count-1 {
                history.dailyHealth[i+1] = history.dailyHealth[i]
            }
            history.dailyHealth[0] = Health()
            history.dailyHealth[0].date = dateString
            history.dailyHealth[0].isValid = true
        }
    }
    func setTodaysCaloriesBurned(cb: Double) {
        check()
        self.history.dailyHealth[0].caloriesBurned = cb
        createData()
        
    }
    func setTodaysFoodCalories(fc: Double) {
        check()
        self.history.dailyHealth[0].foodCalories = fc
        createData()
    }
    
    func setTodaysFoodProtein(fp: Double) {
        check()
        self.history.dailyHealth[0].foodProtein = fp
        createData()
        
    }
    func setTodaysFoodFat(ff: Double) {
        check()
        self.history.dailyHealth[0].foodFat = ff
        createData()
        
    }
    func setTodaysFoodSugar(fs: Double) {
        check()
        self.history.dailyHealth[0].foodSugar = fs
        createData()
        
    }
    func setTodaysWeight(w: Double) {
          check()
        self.history.dailyHealth[0].weight = w
        createData()
    }
    
    
    
    
    func createData() {
        clearData()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let person = NSEntityDescription.insertNewObject(
            forEntityName: "HistoryEntity", into:context)
        
        // Set the attribute values
        person.setValue(self.history, forKey: "history")
        person.setValue(Constant.currentUser, forKey: "user")
        do {
            try context.save()
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func retrieveData() {
        //As we know that container is set up in the AppDelegates so we need to refer that container.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //We need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //Prepare the request of type NSFetchRequest  for the entity
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "HistoryEntity")
        print("We're here \(Constant.currentUser)")
        let predicate = NSPredicate(format: "user = %@", Constant.currentUser)
        fetchRequest.predicate = predicate
        
        //        fetchRequest.fetchLimit = 1
        //        fetchRequest.predicate = NSPredicate(format: "username = %@", "Ankur")
        //        fetchRequest.sortDescriptors = [NSSortDescriptor.init(key: "email", ascending: false)]
        //
        do {
            let result = try managedContext.fetch(fetchRequest)
            for data in result as! [NSManagedObject] {
                let history = data.value(forKey: "history") as! History
                self.history = history
            }
        }catch {
            
            print("Failed")
        }
    }
    func clearData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //We need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "HistoryEntity")
        let predicate = NSPredicate(format: "user = %@", Constant.currentUser)
        fetchRequest.predicate = predicate
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try managedContext.execute(deleteRequest)
            try managedContext.save()
        } catch let error as NSError {
            // TODO: handle the error
            print(error.description + "clear data error")
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
    func getHealthForDay(day: Int = 0) ->Health {
        check()
        return self.history.dailyHealth[day]
    }
}


