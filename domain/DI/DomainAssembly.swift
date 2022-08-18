//
//  DomainAssembly.swift
//  domain
//
//  Created by Karim Karimov on 30.07.22.
//

import Foundation
import Swinject

public class DomainAssembly: Assembly {
    
    public init() {
        
    }
   
    public func assemble(container: Container) {
        container.register(GetUserUseCase.self) { r in
            GetUserUseCase.init(repo: r.resolve(UserRepoProtocol.self)!)
        }
        
        container.register(SyncUserUseCase.self) { r in
            SyncUserUseCase.init(repo: r.resolve(UserRepoProtocol.self)!)
        }
        
        container.register(ObserveUserUseCase.self) { r in
            ObserveUserUseCase.init(repo: r.resolve(UserRepoProtocol.self)!)
        }
    }
}
