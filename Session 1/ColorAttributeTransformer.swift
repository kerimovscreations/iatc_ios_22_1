//
//  ColorAttributeTransformer.swift
//  Session 1
//
//  Created by Karim Karimov on 25.06.22.
//

import UIKit

class ColorAttributeTransformer: NSSecureUnarchiveFromDataTransformer {
    
    override static var allowedTopLevelClasses: [AnyClass] {
        [UIColor.self]
    }
    
    static func register() {
        let className =
          String(describing: ColorAttributeTransformer.self)
        let name = NSValueTransformerName(className)
        let transformer = ColorAttributeTransformer()
        ValueTransformer.setValueTransformer(
          transformer, forName: name)
      }
}
