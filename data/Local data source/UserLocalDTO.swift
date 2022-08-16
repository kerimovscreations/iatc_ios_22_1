//
//  UserLocalDTO.swift
//  data
//
//  Created by Karim Karimov on 30.07.22.
//

import Foundation
import domain
import RealmSwift

class UserLocalDTO: Object {
    static func == (lhs: UserLocalDTO, rhs: UserLocalDTO) -> Bool {
        return lhs.name == rhs.name && lhs.email == rhs.email
    }
    
    @Persisted var name: String = ""
    @Persisted var email: String = ""
    @Persisted var phoneNumber1: String = ""
    
    func toDomain() -> UserEntity {
        return UserEntity(
            name: self.name,
            email: self.email,
            phone: self.phoneNumber1)
    }
}
