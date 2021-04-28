//
//  HealthKitManager.swift
//  PokemonDayCare
//
//  Created by Adrian Impedovo on 20/09/2016.
//  Copyright © 2016 Adrian Impedovo. All rights reserved.
//

import Foundation
import HealthKit
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


class HealthKitManager {
    let storage = HKHealthStore()
    static var dailyStepGoal = 10000
    
    init()
    {
        checkAuthorization()
    }
    
    func checkAuthorization() -> Bool
    {
        // Default to assuming that we're authorized
        var isEnabled = true
        
        // Do we have access to HealthKit on this device?
        if HKHealthStore.isHealthDataAvailable()
        {
            // We have to request each data type explicitly
            let steps = NSSet(object: HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)!)
            
            // Now we can request authorization for step count data
            storage.requestAuthorization(toShare: nil, read: steps as? Set<HKObjectType>) { (success, error) -> Void in
                isEnabled = success
            }
        }
        else
        {
            isEnabled = false
        }
        
        return isEnabled
    }
    
    func recentSteps(_ startDate : Date, endDate: Date, completion: @escaping (Double, NSError?) -> () )
    {
        //print("recentSteps start: ")
        //print(startDate)
        //print("recentSteps end: ")
        //print(endDate)
        // The type of data we are requesting (this is redundant and could probably be an enumeration
        let type = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)
        
        // Our search predicate which will fetch data from now until a day ago
        // (Note, 1.day comes from an extension
        // You'll want to change that to your own NSDate
        
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)
        let predicate2 = HKQuery.predicateForObjects(withDeviceProperty: HKDevicePropertyKeyModel, allowedValues: ["Watch"])
        
        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [predicate, predicate2])
        
        // The actual HealthKit Query which will fetch all of the steps and sub them up for us.
        let query = HKSampleQuery(sampleType: type!, predicate: compoundPredicate, limit: 0, sortDescriptors: nil) { query, results, error in
            var steps: Double = 0
            
            if results?.count > 0
            {
                for result in results as! [HKQuantitySample]
                {
                    steps += result.quantity.doubleValue(for: HKUnit.count())
                }
            }
            
            completion(steps, error as NSError?)
        }
        
        storage.execute(query)
    }

    
    func TodayTotalSteps(_ completion: @escaping (_ stepRetrieved: Double) -> Void) {
        
        let type = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount) // The type of data we are requesting
        
        let calendar = Calendar.current
        var interval = DateComponents()
        interval.day = 1
        
        var anchorComponents = (calendar as NSCalendar).components([.day , .month , .year], from: Date())
        anchorComponents.hour = 0
        let anchorDate = calendar.date(from: anchorComponents)
        
        //print("anchorDate: ")
        //print(anchorDate)
        let predicate = HKQuery.predicateForObjects(withDeviceProperty: HKDevicePropertyKeyModel, allowedValues: ["Watch"])
        let stepsQuery = HKStatisticsCollectionQuery(quantityType: type!, quantitySamplePredicate: predicate, options: .cumulativeSum, anchorDate: anchorDate!, intervalComponents: interval)
        
        stepsQuery.initialResultsHandler = {query, results, error in
            let endDate = Date()
            
            var steps = 0.0
            let startDate = (calendar as NSCalendar).date(byAdding: .day, value: 0, to: endDate, options: [])
            if let myResults = results{  myResults.enumerateStatistics(from: startDate!, to: endDate) { statistics, stop in
                if let quantity = statistics.sumQuantity(){
                    //let date = statistics.startDate
                    steps = quantity.doubleValue(for: HKUnit.count())
                    // print("\(date): steps = \(steps)")
                }
                
                completion(steps)
                }
            } else {
                
                completion(steps)
            }
        }
        storage.execute(stepsQuery)
    }
}
