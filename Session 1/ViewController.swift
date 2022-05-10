//
//  ViewController.swift
//  Session 1
//
//  Created by Karim Karimov on 05.04.22.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let r1 = Rect(color: "red", width: 2, height: 4)
        //        r1.printDesc()
        print(r1.width)
        print(r1.height)
        
        (r1 as Shape).printDesc() // successs
        let sh1: Shape = r1
        sh1.printDesc()
        
        let sh2: Shape = Rect(color: "blue", width: 2, height: 3)
        
        if let r2 = sh2 as? Rect {
            print(r2.width)
        } else {
            print("cannot downcast")
        }
        
        let shapes: [Shape] = [
            Rect(color: "yellow", width: 2, height: 3),
            Circle(color: "green", radius: 7)
        ]
        
        let characters: [Any] = [
            Rect(color: "yellow", width: 2, height: 3),
            Circle(color: "green", radius: 7),
            3,
            #selector(printTest)
        ]
        
        shapes.forEach { shape in
            if let obj = shape as? Any {
                print("it is an object \(obj)")
            } else if let rect = shape as? Rect {
                print("it is a rect \(rect)")
            } else if let circle = shape as? Circle {
                print("it is a circle \(circle)")
            } else {
                print("cannot downcast")
            }
        }
        
        let selection: Selection = .number(0)
        
        switch selection {
        case .textField(let textSelection):
            print(textSelection.name)
        case .number(let num):
            print("number: \(num)")
        case .datePicker(let date):
            print(date)
        }
    }
    
    @objc func printTest() {
        
    }
}

class Shape {
    var color: String
    
    init(color: String) {
        self.color = color
    }
    
    required init() {
        self.color = "not defined"
    }
    
    func printDesc() {
        print("color: \(color)")
    }
}

class Rect: Shape {
    var width: Int
    var height: Int
    
    init(color: String, width: Int, height: Int) {
        self.width = width
        self.height = height
        
        super.init()
        self.color = color
    }
    
    required init() {
        self.width = 1
        self.height = 1
        super.init()
    }
    
    override func printDesc() {
        print("rect color: \(color)")
    }
    
    func printDesc(prefix: String) {
        
    }
    
    func printDesc(suffix: String) {
        
    }
}

class Circle: Shape {
    var radius: Int {
        get {
            return 0
        }
        set {
            self.radius = newValue
        }
    }
    
    init(color: String, radius: Int) {
//        self.radius = radius
        super.init(color: color)
    }
    
    required init() {
//        self.radius = 0
        super.init()
        self.radius = 0
    }
}

enum Selection {
    case textField(TextSelection), number(Int), datePicker(Date)
}

struct TextSelection {
    let name: String
    let surname: String
}
