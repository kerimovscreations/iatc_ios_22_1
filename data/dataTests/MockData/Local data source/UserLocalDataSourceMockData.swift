//
//  UserLocalDataSourceMockData.swift
//  dataTests
//
//  Created by Karim Karimov on 06.08.22.
//

import Foundation
import Promises
import RxSwift
import RxRelay
@testable import data

class UserLocalDataSourceMockData: UserLocalDataSourceProtocol {
    
    var savePromise = Promise<Void>.pending()
    var observeUserValue = PublishRelay<UserLocalDTO>()
    
    private let saveCall = PublishRelay<UserLocalDTO>()
    
    func observeUser() -> Observable<UserLocalDTO> {
        return self.observeUserValue.asObservable()
    }
    
    func save(userDto: UserLocalDTO) -> Promise<Void> {
        self.saveCall.accept(userDto)
        return self.savePromise
    }
    
    func observeSaveCall() -> Observable<UserLocalDTO> {
        return self.saveCall.asObservable()
    }
    
}
