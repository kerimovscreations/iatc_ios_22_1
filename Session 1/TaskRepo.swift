//
//  TaskRepo.swift
//  Session 1
//
//  Created by Karim Karimov on 25.06.22.
//

import Foundation

class TaskRepo {
    
    private let userDefaults = UserDefaults.standard
    
    func saveTask(id: String, value: String) {
        userDefaults.set(value, forKey: id)
    }
    
    func getTask(id: String) -> String? {
        return userDefaults.string(forKey: id)
    }
    
    func saveTask(id: String, task: Task) {
        let encoder = JSONEncoder.init()
        
        if let data = try? encoder.encode(task) {
            userDefaults.set(data, forKey: id)
        }
    }
    
    func getTaskModel(id: String) -> Task? {
        if let data = self.userDefaults.data(forKey: id) {
            let decoder = JSONDecoder.init()
            
            if let task = try? decoder.decode(Task.self, from: data) {
                return task
            }
        }
        
        return nil
    }
}
