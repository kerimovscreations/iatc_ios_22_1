//
//  ViewController.swift
//  Session 1
//
//  Created by Karim Karimov on 05.04.22.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    // MARK: - UI Components
    
    
    // MARK: - Variables
    
    private let vm = ViewModel()
    
    
    // MARK: - Parent delegates
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white

//        self.vm.setTask(title: "Wash teeth 3") // id = 1
//        self.vm.setTask(title: "Clean room 2") // id = 2
//        self.vm.setTask(title: "Have a breakfast") // = 3
        
//        if let task2 = self.vm.getTask(by: 2) {
//            print("My task 2: \(task2)")
//        }
        
//        if let taskModel3 = self.vm.getTaskModel(by: 3) {
//            print("My task 3: \(taskModel3.title)")
//        }
        
//        self.vm.saveUser(name: "Bob Doe", email: "bob@company.com")
//
//        if let name = self.vm.getFirstUserName() {
//            print("First user name: \(name)")
//        }
//
//        if let name = self.vm.getLastUserName() {
//            print("Last user name: \(name)")
//        }
        
//        self.vm.saveUserWithCars(
//            name: "Rich5 member",
//            email: "rich5@company.com",
//            carModels: [
//                (model: "Mercedes", color: UIColor.black),
//                (model: "Volvo", color: UIColor.blue)
//            ]
//        )
        
//        if let richUser = self.vm.getUserWithCars(email: "rich5@company.com") {
////            print(richUser)
//            print("user name: \(richUser.fullName ?? "NA"),\nemail: \(richUser.email ?? "NA"),\nid: \(richUser.id?.uuidString ?? "NA")")
//
////            richUser.cars?.enumerated().forEach({ body in
////                body.element
////            })
//
//            richUser.cars?.enumerated().forEach({ iterator in
//                if let car = iterator.element as? Car {
//                    print("rich user car model: \(car.model ?? "NA")\ncolor: \(car.color.hashValue)")
//                }
//            })
//
////            if let cars = richUser.cars?.enumerated() as? NSOrderedSet<Car> {
////                cars.forEach({ car in
////                    print("rich user car model: \(car.model ?? "NA")")
////                })
////            }
//        }
        
        self.vm.saveUserWithCars(
            name: "Rich6 member",
            email: "rich6@company.com",
            age: 200,
            carModels: [
                (model: "Mercedes", color: UIColor.black),
                (model: "Volvo", color: UIColor.blue)
            ]
        )
    }
}
