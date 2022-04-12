//
//  ViewController.swift
//  Session 1
//
//  Created by Karim Karimov on 05.04.22.
//

import UIKit

class ViewController: UIViewController {
    
    private let vm = MainViewModel()
    
    private var mutableStringText = "text1"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("viewDidLoad")
        
        self.view.backgroundColor = .white
        
        print("Width: \(self.view.frame.width)")
        print("Height: \(self.view.frame.height)")
        
        let label = UILabel()
        label.frame = CGRect.init(x: 100, y: 100, width: 100, height: 30)
        label.text = "Test1 Test1 Test1 Test1"
        label.textColor = UIColor.init(red: 0.4, green: 0.1, blue: 0.7, alpha: 1.0)
        label.backgroundColor = .lightGray
        self.view.addSubview(label)
        
        self.mutableStringText = self.process()
        self.mutableStringText = self.processAdd(text: self.mutableStringText)
        
        var listIntegers = [1, 2, 3, 4, 5, 6]
        
        print(listIntegers)
        
        // forEach
        
        var sum = 0
        listIntegers.forEach { number in
            sum = sum + number
        }
        
        print(sum)
        
        // map
        
        let listNumbersStruct = listIntegers.map { number in
            return NumberStruct(displayTitle: "\(number)", value: number)
        }
        
        print(listNumbersStruct)
        
        // filter
        
        let listNumberOdds = listIntegers.filter { number in
            return number % 2 == 1
        }
        print(listNumberOdds)
        
        // reduce
        
        let sumReduced = listIntegers.reduce(0) { partialResult, next in
            partialResult + next
        }
        print(sumReduced)
        
        // complex
                
        let sumReducedCollection = listIntegers.filter { number in
            number >= 3
        }.reduce([NumberStruct]()) { partialResult, number in
            var lastArray = partialResult
            lastArray.append(NumberStruct(displayTitle: "\(number)", value: number))
            return lastArray
        }
        print(sumReducedCollection)
        
        let instance = SingleStruct.shared
        let sum5 = instance.add(value1: 2, value2: 3)
        
        print("Unread message count: \(instance.getUnreadNotification())")
        
        instance.addUnreadNotifications(number: 4)
        
        print("Unread message count: \(instance.getUnreadNotification())")
        
        let childInstance = ViewControllerChild()
        
        print("Unread message count: \(childInstance.checkUnreadNotificationSum())")
        
        instance.readAll()
        print("Read all notifications")
        
        print("Unread message count: \(instance.getUnreadNotification())")
        print("Unread message count: \(childInstance.checkUnreadNotificationSum())")
        
        print("Builder")
        
        let car = Car.Builder()
            .setColor(.red)
            .setFuelType(EngineFuel.diesel)
            .setPassengetSize(5)
            .build()
        
        print(car.fuelType)
        print(car.passengerSize)
        print(car.color)
        
        
        print("Factory method")
        
        let greenCar = CarFactory.build(fuelType: .diesel, color: .green)
        
        let cars = vm.getCars()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("viewWillAppear")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print(#function)
    }
    
    func process() -> String {
        return "text2"
    }
    
    func processAdd(text: String) -> String {
        return text + "1"
    }
}

class ViewControllerChild {
    
    func checkUnreadNotificationSum() -> Int {
        return SingleStruct.shared.getUnreadNotification()
    }
}

struct NumberStruct {
    let displayTitle: String
    let value: Int
}
