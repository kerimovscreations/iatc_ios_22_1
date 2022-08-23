//
//  UserRepo.swift
//  data
//
//  Created by Karim Karimov on 30.07.22.
//

import Foundation
import domain
import RxSwift
import Promises

class UserRepo: UserRepoProtocol {
    
    private let remoteDataSource: UserRemoteDataSourceProtocol
    private let localDataSource: UserLocalDataSourceProtocol
    private let socketProvider: SocketProviderProtocol
        
    init(remoteDataSource: UserRemoteDataSourceProtocol,
         localDataSource: UserLocalDataSourceProtocol,
         socketProvider: SocketProviderProtocol
    ) {
        self.remoteDataSource = remoteDataSource
        self.localDataSource = localDataSource
        self.socketProvider = socketProvider
    }
    
    func getUser() -> Promise<UserEntity> {
        self.remoteDataSource.fetchUser()
            .then { dto in
                dto.toDomain()
            }
    }
    
    func observeUser() -> Observable<UserEntity> {
        return self.localDataSource.observeUser().map { dto in
            dto.toDomain()
        }
    }
    
    func syncUser() -> Promise<Void> {
        let promise = Promise<Void>.pending()
        
        self.remoteDataSource.fetchUser()
            .then { dto -> Promise<Void> in
                let local = dto.toLocal()
                return self.localDataSource.save(userDto: local)
            }
            .then { void in
                promise.fulfill(void)
            }
            .catch { error in
                promise.reject(error)
            }
        
        return promise
    }
    
    func send(message: String) {
        self.socketProvider.send(message: message)
    }
    
    func observeMessage() -> Observable<String> {
        return self.socketProvider.observeMessages()
    }
    
}
