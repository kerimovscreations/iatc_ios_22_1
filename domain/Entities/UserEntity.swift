//
//  UserEntity.swift
//  domain
//
//  Created by Karim Karimov on 30.07.22.
//

import Foundation

public struct UserEntity {
    public let name: String
    public let email: String
    public let phone: String
    
    public init(
        name: String,
        email: String,
        phone: String
    ) {
        self.name = name
        self.email = email
        self.phone = phone
    }
}
