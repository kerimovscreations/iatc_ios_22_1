//
//  ObserveUserUseCase.swift
//  domain
//
//  Created by Karim Karimov on 30.07.22.
//

import Foundation
import RxSwift

public class ObserveUserUseCase {
    
    private let repo: UserRepoProtocol
    
    init(repo: UserRepoProtocol) {
        self.repo = repo
    }
    
    public func execute() -> Observable<UserEntity> {
        return repo.observeUser()
    }
}
