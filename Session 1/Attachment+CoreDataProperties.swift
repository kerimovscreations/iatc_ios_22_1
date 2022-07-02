//
//  Attachment+CoreDataProperties.swift
//  Session 1
//
//  Created by Karim Karimov on 02.07.22.
//
//

import Foundation
import CoreData


extension Attachment {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Attachment> {
        return NSFetchRequest<Attachment>(entityName: "Attachment")
    }

    @NSManaged public var dateCreated: Date
    @NSManaged public var note: Note?

}

extension Attachment : Identifiable {

}
