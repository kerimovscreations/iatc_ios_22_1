//
//  ViewModel.swift
//  Session 1
//
//  Created by Karim Karimov on 18.06.22.
//

import Foundation
import UIKit
import RealmSwift
import Realm

enum TaskStatusEnum: String, PersistableEnum {
    case notStarted
    case inProgress
    case complete
}


class User: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var _partition: String = ""
    @Persisted var name: String = ""
    // A user can have many tasks.
    @Persisted var tasks: List<Task>
}
class Task: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var _partition: String = ""
    @Persisted var text: String = ""
    @Persisted var duration: Double = 0.0
    // Backlink to the user. This is automatically updated whenever
    // this task is added to or removed from a user's task list.
    @Persisted(originProperty: "tasks") var assignee: LinkingObjects<User>
}

class Person: Object {
    @Persisted var name: String = ""
    @Persisted var birthdate: Date = Date(timeIntervalSince1970: 1)
    // A person can have many dogs
    @Persisted var dogs: List<Dog>
    
    convenience init(name: String) {
        self.init()
        
        self.name = name
    }
}
class Dog: Object {
    @Persisted var name: String = ""
    @Persisted var age: Int = 0
    @Persisted var breed: String?
    // No backlink to person -- one-directional relationship
}

class ViewModel {
    
    let defaultRealm = try! Realm(
        configuration: Realm.Configuration(
        schemaVersion: 3,
        migrationBlock: ({ migration, oldSchemaVersion in
            if oldSchemaVersion < 2 {
                migration.enumerateObjects(ofType: User.className()) { oldObject, newObject in
                    let name = oldObject!["name"] as? String
                    newObject!["newName"] = "\(name ?? "") new"
                }

            } else if oldSchemaVersion < 3 {
                migration.renameProperty(onType: Person.className(), from: "age", to: "yearsSinceBirth")
            }
        })
        )
    )
    
    func getData() {
        
        
        let dogs = self.defaultRealm.objects(Dog.self)
        
        let filteredDogs = dogs.where({ element in
            element.name.starts(with: "a")
        }).sorted { dog1, dog2 in
            dog1.name > dog2.name
        }
        
        filteredDogs.forEach { dog in
            print(dog.name)
        }
        
        
        
        let users = self.defaultRealm.objects(User.self)
        
        let hardWorkers = users.where { user in
            user.tasks.duration.avg > 5
        }
        
        try! self.defaultRealm.write({
            self.defaultRealm.delete(hardWorkers)
        })
        
        hardWorkers.forEach { user in
            print(user)
        }
        
        print("Completed")
    }
    
    func writeData() {
        let user1 = User()
        
        user1.name = "User 1"
        user1.tasks = List<Task>()
        
        let task1 = Task()
        task1.duration = 6
        
        let task2 = Task()
        task2.duration = 4
        
        let task3 = Task()
        task3.duration = 1
        
        user1.tasks.append(task1)
        user1.tasks.append(task2)
        user1.tasks.append(task3)
        
        try! self.defaultRealm.write({
            self.defaultRealm.add(user1)
        })
        
        let user2 = User()
        
        user2.name = "User 2"
        user2.tasks = List<Task>()
        
        let task11 = Task()
        task11.duration = 6
        
        let task21 = Task()
        task21.duration = 10
        
        let task31 = Task()
        task31.duration = 8
        
        user2.tasks.append(task11)
        user2.tasks.append(task21)
        user2.tasks.append(task31)
        
        try! self.defaultRealm.write({
            self.defaultRealm.add(user2)
        })
    }
    
}
