//
//  UserRemoteDTO.swift
//  data
//
//  Created by Karim Karimov on 30.07.22.
//

import Foundation
import domain

struct UserRemoteDTO: Decodable, Equatable {
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
        let dto = UserLocalDTO()
        
        dto.name = self.name
        dto.email = self.email
        dto.phoneNumber1 = self.phoneNumber
        
        return dto
    }
}
