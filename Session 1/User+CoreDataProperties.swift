//
//  User+CoreDataProperties.swift
//  Session 1
//
//  Created by Karim Karimov on 25.06.22.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var fullName: String?
    @NSManaged public var email: String?
    @NSManaged public var id: UUID?
    @NSManaged public var photo: Data?
    @NSManaged public var age: Int16
    @NSManaged public var cars: NSOrderedSet?

}

// MARK: Generated accessors for cars
extension User {

    @objc(insertObject:inCarsAtIndex:)
    @NSManaged public func insertIntoCars(_ value: Car, at idx: Int)

    @objc(removeObjectFromCarsAtIndex:)
    @NSManaged public func removeFromCars(at idx: Int)

    @objc(insertCars:atIndexes:)
    @NSManaged public func insertIntoCars(_ values: [Car], at indexes: NSIndexSet)

    @objc(removeCarsAtIndexes:)
    @NSManaged public func removeFromCars(at indexes: NSIndexSet)

    @objc(replaceObjectInCarsAtIndex:withObject:)
    @NSManaged public func replaceCars(at idx: Int, with value: Car)

    @objc(replaceCarsAtIndexes:withCars:)
    @NSManaged public func replaceCars(at indexes: NSIndexSet, with values: [Car])

    @objc(addCarsObject:)
    @NSManaged public func addToCars(_ value: Car)

    @objc(removeCarsObject:)
    @NSManaged public func removeFromCars(_ value: Car)

    @objc(addCars:)
    @NSManaged public func addToCars(_ values: NSOrderedSet)

    @objc(removeCars:)
    @NSManaged public func removeFromCars(_ values: NSOrderedSet)

}

extension User : Identifiable {

}
