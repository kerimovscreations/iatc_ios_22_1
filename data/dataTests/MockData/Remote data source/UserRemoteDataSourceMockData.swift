//
//  UserRemoteDataSourceMockData.swift
//  dataTests
//
//  Created by Karim Karimov on 06.08.22.
//

import Foundation
import Promises
@testable import data

class UserRemoteDataSourceMockData: UserRemoteDataSourceProtocol {
    
    var fetchUserPromise = Promise<UserRemoteDTO>.pending()
    
    func fetchUser() -> Promise<UserRemoteDTO> {
        return fetchUserPromise
    }
    
    
}
