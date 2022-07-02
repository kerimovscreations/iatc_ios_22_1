//
//  AttachmentToImageAttachmentMigrationPolicyV3toV4.swift
//  Session 1
//
//  Created by Karim Karimov on 02.07.22.
//

import CoreData

let errorDomain = "Migration"

class AttachmentToImageAttachmentMigrationPolicyV3toV4:
    NSEntityMigrationPolicy {
    
    override func createDestinationInstances(
        forSource sInstance: NSManagedObject,
        in mapping: NSEntityMapping,
        manager: NSMigrationManager
    ) throws { // 1
        let description = NSEntityDescription.entity(
            forEntityName: "ImageAttachment",
            in: manager.destinationContext)
        let newAttachment = ImageAttachment(
            entity: description!,
            insertInto: manager.destinationContext
        )
        // 2
        func traversePropertyMappings(
            block: (NSPropertyMapping, String) -> Void
        ) throws {
            if let attributeMappings = mapping.attributeMappings {
                for propertyMapping in attributeMappings {
                    if let destinationName = propertyMapping.name {
                        block(propertyMapping, destinationName)
                    } else {
                        // 3
                        let message =
                        "Attribute destination not configured properly"
                        let userInfo =
                        [NSLocalizedFailureReasonErrorKey: message]
                        throw NSError(domain: errorDomain,
                                      code: 0, userInfo: userInfo)
                    } }
            } else {
                let message = "No Attribute Mappings found!"
                let userInfo = [NSLocalizedFailureReasonErrorKey: message]
                throw NSError(domain: errorDomain,
                              code: 0, userInfo: userInfo)
            }
            
        }
        
        // 4
        // dateCreated; image
        try traversePropertyMappings { propertyMapping,
            destinationName in
            if let valueExpression = propertyMapping.valueExpression {
                let context: NSMutableDictionary = ["source": sInstance]
                guard let destinationValue =
                        valueExpression.expressionValue(
                            with: sInstance,
                            context: context
                        ) else {
                    return
                }
                newAttachment.setValue(destinationValue,
                                       forKey: destinationName)
            }
            
        }
        // 5
        // width; height
        newAttachment.setValue(100.0, forKey: "width")
        newAttachment.setValue(200.0, forKey: "height")
        // 6
        let body = sInstance.value(
            forKeyPath: "note.body"
        ) as? NSString ?? ""
        newAttachment.setValue(
            body.substring(to: 3),
            forKey: "caption"
        )
        // 7
        manager.associate(
            sourceInstance: sInstance,
            withDestinationInstance: newAttachment,
            for: mapping
        )
        
    }
}
