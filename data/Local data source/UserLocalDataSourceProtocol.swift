//
//  UserLocalDataSourceProtocol.swift
//  data
//
//  Created by Karim Karimov on 30.07.22.
//

import Foundation
import RxSwift
import Promises

protocol UserLocalDataSourceProtocol {
    func observeUser() -> Observable<UserLocalDTO>
    func save(userDto: UserLocalDTO) -> Promise<Void>
}
