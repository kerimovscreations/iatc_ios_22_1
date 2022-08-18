//
//  ViewModel.swift
//  Session 1
//
//  Created by Karim Karimov on 18.06.22.
//

import Foundation
import Swinject

class ViewModel {
    
    let container = Container()
    
    weak var animal: Cat!
    
    func testDI() {
        container.register(Animal.self, name: "cat") { _ in
            return Cat()
        }
        
        container.register(Animal.self, name: "dog") { _ in
            return Dog()
        }
        
        let justAnimalCat = container.resolve(Animal.self, name: "cat")!
        
        print(justAnimalCat.name)
        
        let justDogAnimal = container.resolve(Animal.self, name: "dog")!
        
        print(justDogAnimal.name)
        
        container.register(Animal.self) { _, speed in
            return Horse(speed: speed)
        }
        
        container.register(Animal.self) { _, color in
            return Snail(color: color)
        }
        
        let speed: Int = 25
        let horse1 = container.resolve(Animal.self, argument: speed)!
        
        print((horse1 as! Horse).speed)
        
        let snail1 = container.resolve(Animal.self, argument: "brown")!
        
        print((snail1 as! Snail).color)
        
        container.register(Person.self) { resolver in
            return PetOwner(animal: resolver.resolve(Animal.self, name: "cat")!)
        }
        
        container.register(Person.self, name: "dog") { resolver in
            return PetOwner(animal: resolver.resolve(Animal.self, name: "dog")!)
        }
        
        print("Person resolvers")
        
        let defaultOwner = container.resolve(Person.self)!
        
        print(defaultOwner.animal.name)
        
        let dogOwner = container.resolve(Person.self, name: "dog")!
        
        print(dogOwner.animal.name)
        
        container.register(Person2.self) { resolver in
            let owner2 = PetOwner2()
            owner2.animal = resolver.resolve(Animal.self, name: "cat")!
            return owner2
        }
        
        let defaultOwner1 = container.resolve(Person2.self)!
        
        print(defaultOwner1.animal?.name ?? "not found")
        
        container.register(Person2.self, name: "method") { _ in
            return PetOwner3()
        }.initCompleted { resolver, petOwner3 in
            (petOwner3 as! PetOwner3).setAnimal(animal: resolver.resolve(Animal.self, name: "dog")!)
        }
        
        let methodInjDogOwner = container.resolve(Person2.self, name: "method")!
        
        print(methodInjDogOwner.animal?.name ?? "not found")
    }
}

protocol Animal {
    var name: String { get set }
}

class Cat: Animal {
    var name: String = "cat1"
}

class Dog: Animal {
    var name: String = "dog1"
}

class Horse: Animal {
    var name: String = "mustang"
    let speed: Int
    
    init(speed: Int) {
        self.speed = speed
    }
}

class Snail: Animal {
    var name: String = "slow"
    let color: String
    
    init(color: String) {
        self.color = color
    }
}

protocol Person {
    var animal: Animal { get set }
}

class PetOwner: Person {
    var animal: Animal
    
    init(animal: Animal) {
        self.animal = animal
    }
}

protocol Person2 {
    var animal: Animal? { get set }
}

class PetOwner2: Person2 {
    var animal: Animal?
    
    init() {
        self.animal = nil
    }
}

class PetOwner3: Person2 {
    var animal: Animal?
    
    func setAnimal(animal: Animal) {
        self.animal = animal
    }
}
