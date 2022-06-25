//
//  ViewModel.swift
//  Session 1
//
//  Created by Karim Karimov on 18.06.22.
//

import Foundation
import UIKit

class ViewModel {
    
    private let taskRepo = TaskRepo()
    private let userRepo = UserRepo()
    
    private var idIncrement: Int = 0
    
    func setTask(title: String) {
        idIncrement += 1
        
//        taskRepo.saveTask(id: "task_\(idIncrement)", value: title)
        taskRepo.saveTask(
            id: "task_model_\(idIncrement)",
            task: Task(title: title)
            )
    }
    
    func getTask(by id: Int) -> String? {
        return taskRepo.getTask(id: "task_\(id)")
    }
            
    func getTaskModel(by id: Int) -> Task? {
        return taskRepo.getTaskModel(id: "task_model_\(id)")
    }
    
    func saveUser(name: String, email: String) {
        self.userRepo.saveUser(name: name, email: email)
    }
    
    func getFirstUserName() -> String? {
        return self.userRepo.getUserName()
    }
    
    func getLastUserName() -> String? {
        return self.userRepo.getLastUserName()
    }
    
    func saveUserWithCars(
        name: String,
        email: String,
        age: Int16,
        carModels: [(model: String, color: UIColor)]
    ) {
        self.userRepo.saveUserWithCars(
            name: name,
            email: email,
            age: age,
            cars: carModels
        )
    }
    
    func getUserWithCars(email: String) -> User? {
        return self.userRepo.getUserWithCars(by: email)
    }
}
