//
//  ViewModel.swift
//  Session 1
//
//  Created by Karim Karimov on 18.06.22.
//

import Foundation
import UIKit
import CoreData

class ViewModel {
    
    private let dataStack = CoreDataStack(modelName: "Restaurant")
    
    // predicates
    
    private lazy var cheaperMidPricePredicate: NSPredicate = {
        return NSPredicate(format: "%K < %f", #keyPath(Restaurant.midPrice), 500.0)
    }()
    
    // sorting
    
    private lazy var nameSortDesc: NSSortDescriptor = {
        let compareSelector = #selector(NSString.localizedStandardCompare(_:))
        
        return NSSortDescriptor(
            key: #keyPath(Restaurant.name),
            ascending: true,
            selector: compareSelector
        )
    }()
    
    private lazy var distanceDesc: NSSortDescriptor = {
        return NSSortDescriptor(key: #keyPath(Restaurant.distance), ascending: true)
    }()

    func seedData() {
        if let path = Bundle.main.path(forResource: "restaurants", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                
                let decoding = JSONDecoder.init()
                
                let restaurants = try decoding.decode([RestaurantCodable].self, from: data)
                
                //                print(restaurants)
                
                
                let context = dataStack.managedContext
                
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSz"
                
                try restaurants.forEach { restaurant in
                    
                    let objRestaurant = Restaurant(entity: Restaurant.entity(), insertInto: context)
                    objRestaurant.id = restaurant.id
                    objRestaurant.name = restaurant.name
                    if let date = formatter.date(from: restaurant.createdAt) {
                        objRestaurant.createdAt = date
                    }
                    
                    objRestaurant.rateCount = Int32(restaurant.rate_count)
                    objRestaurant.distance = Int32(restaurant.distance)
                    objRestaurant.midPrice = Double(restaurant.mid_price) ?? 0.0
                    
                    try context.save()
                }
                
                print("done")
            } catch {
                // handle error
            }
        }
    }
    
    func getRestaurants() {
        guard let model = dataStack.managedContext.persistentStoreCoordinator?.managedObjectModel,
              let fetchRequest = model.fetchRequestTemplate(forName: "FetchRequest") as? NSFetchRequest<Restaurant> else {
            print("Cannot find fetch request")
            return
        }
        
        do {
            let restaurans = try dataStack.managedContext.fetch(fetchRequest)
            
            print(restaurans)
        } catch {
            print(error)
        }
    }
    
    func countCheaperRestaurants() {
        let fetchRequest = NSFetchRequest<NSNumber>.init(entityName: "Restaurant")
        fetchRequest.predicate = self.cheaperMidPricePredicate
        fetchRequest.resultType = .countResultType
        
        do {
            let countResult = try dataStack.managedContext.fetch(fetchRequest)
            
            if let count = countResult.first?.intValue {
                print(count)
            }
        } catch {
            print(error)
        }
    }
    
    func countCheaperRestaurants2() {
        let fetchRequest = Restaurant.fetchRequest()
        fetchRequest.predicate = self.cheaperMidPricePredicate
        
        do {
            let countResult = try dataStack.managedContext.count(for: fetchRequest)
            
            print(countResult)
        } catch {
            print(error)
        }
    }
    
    func sumMidPrices() {
        let fetchRequest = NSFetchRequest<NSDictionary>.init(entityName: "Restaurant")
        fetchRequest.resultType = .dictionaryResultType
        
        let sumExpressionDesc = NSExpressionDescription()
        sumExpressionDesc.name = "sumMidPrice"
        
        let sumExpression = NSExpression(forKeyPath: #keyPath(Restaurant.midPrice))
        sumExpressionDesc.expression = NSExpression(forFunction: "sum:", arguments: [sumExpression])
        sumExpressionDesc.expressionResultType = .doubleAttributeType
        
        fetchRequest.propertiesToFetch = [sumExpressionDesc]
        
        do {
            let result = try dataStack.managedContext.fetch(fetchRequest)
            
            if let dict = result.first {
                let sumMidPrice = dict["sumMidPrice"] as? Double ?? 0.0
                
                print(sumMidPrice)
            }
        } catch {
            print(error)
        }
    }
    
    func sortedByName() {
        let fetchRequest = Restaurant.fetchRequest()
        
        fetchRequest.sortDescriptors = [self.nameSortDesc]
        
        do {
            let restaurants = try dataStack.managedContext.fetch(fetchRequest)
            
            restaurants.forEach { restaurant in
                print(restaurant.name ?? "NA")
            }
        } catch {
            print(error)
        }
    }
    
    func sortedByDistance() {
        let fetchRequest = Restaurant.fetchRequest()
        
        fetchRequest.sortDescriptors = [self.distanceDesc]
        
        do {
            let restaurants = try dataStack.managedContext.fetch(fetchRequest)
            
            restaurants.forEach { restaurant in
                print("Distance: \(restaurant.distance) Name: \(restaurant.name ?? "NA")")
            }
        } catch {
            print(error)
        }
    }
    
    func asyncFetchAllRestaurants() {
        let fetchRequest = Restaurant.fetchRequest()
        
        let asyncFetchRequest = NSAsynchronousFetchRequest(fetchRequest: fetchRequest) { result in
            
            result.cancel()

            guard let restaurants = result.finalResult else { return }
            
            print(restaurants.count)
        }
        
        do {
            try dataStack.managedContext.execute(asyncFetchRequest)
        } catch {
            print(error)
        }
    }
    
    func batchUpdateDistance() {
        let batchUpdate = NSBatchUpdateRequest(entityName: "Restaurant")
        
        batchUpdate.propertiesToUpdate = [
            #keyPath(Restaurant.distance): 150,
            #keyPath(Restaurant.midPrice): 100
        ]
        
        batchUpdate.affectedStores = dataStack.managedContext.persistentStoreCoordinator?.persistentStores
        
        batchUpdate.resultType = .updatedObjectsCountResultType
        
        do {
            let batchResult = try dataStack.managedContext.execute(batchUpdate) as? NSBatchUpdateResult
            
            if let count = batchResult?.result as? Int {
                print("Updated elements: \(count)")
            }
        } catch {
            print(error)
        }
    }
    
    func batchDelete() {
        let fetchRequest = NSFetchRequest<NSManagedObjectID>(entityName: "Restaurant")
        fetchRequest.resultType = .managedObjectIDResultType
        
        do {
            let ids = try dataStack.managedContext.fetch(fetchRequest)
            
            if ids.isEmpty {
                return
            }
            
            let batchDelete = NSBatchDeleteRequest(objectIDs: ids)
            
            batchDelete.resultType = .resultTypeCount
            
            let batchResult = try dataStack.managedContext.execute(batchDelete) as? NSBatchDeleteResult
            
            if let count = batchResult?.result as? Int {
                print("Deleted items: \(count)")
            }
        } catch {
            print(error)
        }
        
        
    }
}
