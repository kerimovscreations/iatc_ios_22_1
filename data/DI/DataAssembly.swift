//
//  DataAssembly.swift
//  data
//
//  Created by Karim Karimov on 30.07.22.
//

import Foundation
import Swinject
import domain
import Alamofire
import RealmSwift

public class DataAssembly: Assembly {
    
    public init() {
        
    }
    
    public func assemble(container: Container) {
        container.register(UserRepoProtocol.self) { r in
            UserRepo(
                remoteDataSource: r.resolve(UserRemoteDataSourceProtocol.self)!,
                localDataSource: r.resolve(UserLocalDataSourceProtocol.self)!
            )
        }
        
        container.register(UserRemoteDataSourceProtocol.self) { r in
            UserRemoteDataSource(networkProvider: r.resolve(Session.self)!)
        }
        
        container.register(Session.self) { _ in
            return AF
        }
        
        container.register(Realm.self) { _ in
            return try! Realm()
        }
        
        container.register(LocalDataProviderProtocol.self) { r in
            return LocalDataProvider(realm: r.resolve(Realm.self)!)
        }
        
        container.register(UserLocalDataSourceProtocol.self) { r in
            UserLocalDataSource(localDataProvider: r.resolve(LocalDataProviderProtocol.self)!)
        }.inObjectScope(.container)
    }
}
