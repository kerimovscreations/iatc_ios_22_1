//
//  UserRepoMockData.swift
//  domainTests
//
//  Created by Karim Karimov on 06.08.22.
//

import Foundation
import domain
import Promises
import RxSwift
import RxRelay

class UserRepoMockData: UserRepoProtocol {
    
    var getUserPromise = Promise<UserEntity>.pending()
    var syncUserPromise = Promise<Void>.pending()
    
    let observeUserValue = PublishRelay<UserEntity>.init()
    
    func getUser() -> Promise<UserEntity> {
        return self.getUserPromise
    }
    
    func observeUser() -> Observable<UserEntity> {
        return self.observeUserValue.asObservable()
    }
    
    func syncUser() -> Promise<Void> {
        return self.syncUserPromise
    }
    
    
}
