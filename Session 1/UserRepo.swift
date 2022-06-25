//
//  UserRepo.swift
//  Session 1
//
//  Created by Karim Karimov on 25.06.22.
//

import Foundation
import CoreData
import UIKit

class UserRepo {
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Models")
        
        container.loadPersistentStores { description, error in
            if let err = error {
                fatalError("Cannot load persistent container")
            }
        }
        
        return container
    }()
    
    private lazy var managedContext: NSManagedObjectContext = {
        return self.persistentContainer.viewContext
    }()
    
    private lazy var userEntity: NSEntityDescription = {
        return NSEntityDescription.entity(forEntityName: "User", in: managedContext)!
    }()
    
    private lazy var carEntity: NSEntityDescription = {
        return NSEntityDescription.entity(forEntityName: "Car", in: managedContext)!
    }()
    
    init() {
        ColorAttributeTransformer.register()
    }
    
    func saveUser(name: String, email: String) {
        let managedContext = self.managedContext
        
        let userEntity = NSEntityDescription.entity(forEntityName: "User", in: managedContext)!
        
        let user = User(entity: userEntity, insertInto: managedContext)
        
        user.fullName = name
        user.email = email
        user.id = UUID()
        
//        let user = NSManagedObject(entity: userEntity, insertInto: managedContext)
        
//        user.setValue(name, forKey: "fullName")
//        user.setValue(email, forKey: "email")
//        user.setValue(UUID.init(), forKey: "id")
        
        do {
            try managedContext.save()
        } catch {
            print(error)
        }
    }
    
    func getUserName() -> String? {
        let managedContext = self.managedContext
        
//        let fetchRequest = NSFetchRequest<NSManagedObject>.init(entityName: "User")
        
        let fetchRequest = User.fetchRequest()
        
        do {
            let users = try managedContext.fetch(fetchRequest)
            
            if let firstUser = users.first,
               let name = firstUser.fullName {
                return name
            }
            
//            if let firstUser = users.first,
//                let firstName = firstUser.value(forKey: "fullName") as? String {
//                return firstName
//            }
        } catch {
            print(error)
        }
        
        return nil
    }
    
    func getLastUserName() -> String? {
        let managedContext = self.managedContext
        
        let fetchRequest = User.fetchRequest()
        
        do {
            let users = try managedContext.fetch(fetchRequest)
            
            if let firstUser = users.last,
               let name = firstUser.fullName {
                return name
            }
        } catch {
            print(error)
        }
        
        return nil
    }
    
    func saveUserWithCars(
        name: String,
        email: String,
        age: Int16,
        cars: [(model: String, color: UIColor)]) {
        let user = User(entity: self.userEntity, insertInto: managedContext)
        
        user.fullName = name
        user.email = email
        user.id = UUID()
        user.age = age
        
        cars.forEach { (model, color) in
            let car = Car(
                entity: carEntity,
                insertInto: managedContext
            )
            car.model = model
            car.color = color
            car.id = UUID()
            user.addToCars(car)
        }
       
        do {
            try managedContext.save()
        } catch {
            print(error)
        }
    }
    
    func getUserWithCars(by email: String) -> User? {
        
        let fetchRequest = User.fetchRequest()
        fetchRequest.predicate =
        NSPredicate(
            format: "%K = %@",
            argumentArray: [#keyPath(User.email), email]
        )
        
        do {
            let users = try managedContext.fetch(fetchRequest)
            
            return users.first
        } catch {
            print(error)
        }
        
        return nil
    }
}
