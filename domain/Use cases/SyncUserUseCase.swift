//
//  SyncUserUseCase.swift
//  domain
//
//  Created by Karim Karimov on 30.07.22.
//

import Foundation
import Promises

public class SyncUserUseCase {
    
    private let repo: UserRepoProtocol
    
    init(repo: UserRepoProtocol) {
        self.repo = repo
    }
    
    public func execute() -> Promise<Void> {
        return repo.syncUser()
    }
}
