//
//  UserRepoProtocol.swift
//  domain
//
//  Created by Karim Karimov on 30.07.22.
//

import Foundation
import Promises
import RxSwift

public protocol UserRepoProtocol {
    func getUser() -> Promise<UserEntity>
    func observeUser() -> Observable<UserEntity>
    func syncUser() -> Promise<Void>
    func send(message: String)
    func observeMessage() -> Observable<String>
}
