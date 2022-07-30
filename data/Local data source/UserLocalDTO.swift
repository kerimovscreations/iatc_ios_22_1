//
//  UserLocalDTO.swift
//  data
//
//  Created by Karim Karimov on 30.07.22.
//

import Foundation
import domain

struct UserLocalDTO {
    let name: String
    let email: String
    let phoneNumber1: String
    
    func toDomain() -> UserEntity {
        return UserEntity(
            name: self.name,
            email: self.email,
            phone: self.phoneNumber1)
    }
}
