//
//  UserRemoteDTO.swift
//  data
//
//  Created by Karim Karimov on 30.07.22.
//

import Foundation
import domain

struct UserRemoteDTO: Decodable {
    let name: String
    let email: String
    let phoneNumber: String
    
    func toDomain() -> UserEntity {
        return UserEntity(
            name: self.name,
            email: self.email,
            phone: self.phoneNumber)
    }
    
    func toLocal() -> UserLocalDTO {
        return UserLocalDTO(
            name: self.name,
            email: self.email,
            phoneNumber1: self.phoneNumber
        )
    }
}
