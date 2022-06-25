//
//  Car+CoreDataProperties.swift
//  Session 1
//
//  Created by Karim Karimov on 25.06.22.
//
//

import Foundation
import CoreData
import UIKit


extension Car {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Car> {
        return NSFetchRequest<Car>(entityName: "Car")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var model: String?
    @NSManaged public var color: UIColor?
    @NSManaged public var owner: User?

}

extension Car : Identifiable {

}
