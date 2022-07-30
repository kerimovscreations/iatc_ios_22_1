//
//  UserRemoteDataSource.swift
//  data
//
//  Created by Karim Karimov on 30.07.22.
//

import Foundation
import Promises
import Alamofire

class UserRemoteDataSource: UserRemoteDataSourceProtocol {
    
    private let networkProvider: Session
    
    init(networkProvider: Session) {
        self.networkProvider = networkProvider
    }
    
    func fetchUser() -> Promise<UserRemoteDTO> {
        let promise = Promise<UserRemoteDTO>.pending()
        
//        self.networkProvider.request("/user")
//            .responseDecodable(of: UserRemoteDTO.self) { response in
//                if let err = response.error {
//                    promise.reject(err)
//                    return
//                }
//
//                if let data = response.value {
//                    promise.fulfill(data)
//                } else {
//                    promise.reject(ParsingError())
//                }
//            }
        
        promise.fulfill(UserRemoteDTO(name: "User 2", email: "user2@example.com", phoneNumber: "343535"))
        
        return promise
    }
}

class ParsingError: Error {
    
}
