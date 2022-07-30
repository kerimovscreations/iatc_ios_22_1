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
        
        container.register(UserLocalDataSourceProtocol.self) { _ in
            UserLocalDataSource()
        }.inObjectScope(.container)
    }
}
