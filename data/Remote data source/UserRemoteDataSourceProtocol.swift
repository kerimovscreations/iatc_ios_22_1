//
//  UserRemoteDataSourceProtocol.swift
//  data
//
//  Created by Karim Karimov on 30.07.22.
//

import Foundation
import Promises

protocol UserRemoteDataSourceProtocol {
    func fetchUser() -> Promise<UserRemoteDTO>
}
