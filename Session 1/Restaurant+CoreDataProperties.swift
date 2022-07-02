//
//  Restaurant+CoreDataProperties.swift
//  Session 1
//
//  Created by Karim Karimov on 28.06.22.
//
//

import Foundation
import CoreData


extension Restaurant {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Restaurant> {
        return NSFetchRequest<Restaurant>(entityName: "Restaurant")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var createdAt: Date?
    @NSManaged public var distance: Int32
    @NSManaged public var rateCount: Int32
    @NSManaged public var midPrice: Double

}

extension Restaurant : Identifiable {

}
