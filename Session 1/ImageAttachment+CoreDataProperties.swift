//
//  ImageAttachment+CoreDataProperties.swift
//  Session 1
//
//  Created by Karim Karimov on 02.07.22.
//
//

import Foundation
import CoreData


extension ImageAttachment {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ImageAttachment> {
        return NSFetchRequest<ImageAttachment>(entityName: "ImageAttachment")
    }

    @NSManaged public var caption: String?
    @NSManaged public var width: Float
    @NSManaged public var height: Float
    @NSManaged public var image: String?

}
