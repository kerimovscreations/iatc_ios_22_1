//
//  UserLocalDataSource.swift
//  data
//
//  Created by Karim Karimov on 30.07.22.
//

import Foundation
import RxSwift
import RxRelay
import Promises

class UserLocalDataSource: UserLocalDataSourceProtocol {
    private let userRelay = BehaviorRelay<UserLocalDTO?>.init(value: nil)
    
    func observeUser() -> Observable<UserLocalDTO> {
        return self.userRelay
            .filter({ dto in
                dto != nil
            })
            .map({ dto in
                dto!
            })
            .asObservable()
    }
    
    func save(userDto: UserLocalDTO) -> Promise<Void> {
        let promise = Promise<Void>.pending()
        
        self.userRelay.accept(userDto)
        
        promise.fulfill(Void())
        
        return promise
    }
}
