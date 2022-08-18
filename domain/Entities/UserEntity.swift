//
//  UserEntity.swift
//  domain
//
//  Created by Karim Karimov on 30.07.22.
//

import Foundation

public struct UserEntity: Equatable {
    public let name: String
    public let email: String
    public let phone: String
    
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.name == rhs.name && lhs.email == rhs.email
    }
    
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
