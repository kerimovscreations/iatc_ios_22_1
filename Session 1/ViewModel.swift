//
//  ViewModel.swift
//  Session 1
//
//  Created by Karim Karimov on 18.06.22.
//

import Foundation
import UIKit
import CoreData

class ViewModel {
    
    private let dataStack = CoreDataStack(modelName: "UnCloudNotesDatamodel")
    
    func addV1Data() {
        let entity = NSEntityDescription.entity(forEntityName: "Note", in: dataStack.managedContext)!
        
        let note1 = Note.init(entity: entity, insertInto: dataStack.managedContext)
        
        note1.body = "Note 1"
        note1.dateCreated = Date()
        note1.displayIndex = 0
        note1.title = "Title 1"
        
        let note2 = Note.init(entity: entity, insertInto: dataStack.managedContext)
        
        note2.body = "Note 2"
        note2.dateCreated = Date()
        note2.displayIndex = 1
        note2.title = "Title 2"
        
        let note3 = Note.init(entity: entity, insertInto: dataStack.managedContext)
        
        note3.body = "Note 3"
        note3.dateCreated = Date()
        note3.displayIndex = 2
        note3.title = "Title 3"
        
        dataStack.saveContext()
        
        print("Saved")
    }
    
    func read() {
        let fetchRequest = Note.fetchRequest()
        
        do {
            let results = try dataStack.managedContext.fetch(fetchRequest)
            
            results.forEach { note in
                print(note.title)
                if let firstAttachment = note.attachments?.first as? ImageAttachment {
                    print(firstAttachment.image)
                } else {
                    print("no attachment")
                }
            }
        } catch {
            print(error)
        }
    }
    
    func readAttachments() {
        let fetchRequest = ImageAttachment.fetchRequest() as NSFetchRequest<ImageAttachment>

        do {
            let results = try dataStack.managedContext.fetch(fetchRequest)

            results.forEach { attachment in
                print(attachment.image)
                print(attachment.caption)
                print(attachment.width)
                if let note = attachment.note {
                    print("note \(note.title)")
                } else {
                    print("no note found")
                }
            }
        } catch {
            print(error)
        }
    }
    
    func addImages() {
        let fetchRequest = Note.fetchRequest()
        
        do {
            let results = try dataStack.managedContext.fetch(fetchRequest)
            
            let attachmentEntity = NSEntityDescription.entity(forEntityName: "Attachment", in: dataStack.managedContext)!
            
            let note1 = results[0]
            
            let attachment1 = ImageAttachment.init(entity: attachmentEntity, insertInto: dataStack.managedContext)
            
            attachment1.image = "image3"
            attachment1.caption = "122"
            attachment1.width = 100.0
            attachment1.height = 50.0
            attachment1.dateCreated = Date()
            attachment1.note = note1
            
            let note2 = results[1]
            
            let attachment2 = ImageAttachment.init(entity: attachmentEntity, insertInto: dataStack.managedContext)
            
            attachment2.image = "image4"
            attachment2.caption = "126"
            attachment2.width = 100.0
            attachment2.height = 50.0
            attachment2.dateCreated = Date()
            attachment2.note = note2
            
            dataStack.saveContext()
        } catch {
            print(error)
        }
    }
}
