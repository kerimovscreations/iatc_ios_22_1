//
//  Note+CoreDataProperties.swift
//  Session 1
//
//  Created by Karim Karimov on 02.07.22.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var body: String?
    @NSManaged public var dateCreated: Date?
    @NSManaged public var displayIndex: Int64
    @NSManaged public var title: String?
    @NSManaged public var attachments: Set<Attachment>?
}

extension Note : Identifiable {
    
    var image: String? {
        return (latestAttachment as? ImageAttachment)?.image
    }
    
    var latestAttachment: Attachment? {
      guard let attachments = attachments,
        let startingAttachment = attachments.first else {
          return nil
      }
      return Array(attachments).reduce(startingAttachment) {
        $0.dateCreated.compare($1.dateCreated)
          == .orderedAscending ? $0 : $1
      }
    }
}
