//
//  ObserveSocketMessageUseCase.swift
//  domain
//
//  Created by Karim Karimov on 23.08.22.
//

import Foundation
import RxSwift

public class ObserveSocketMessageUseCase {
    
    private let repo: UserRepoProtocol
    
    init(repo: UserRepoProtocol) {
        self.repo = repo
    }
    
    public func execute() -> Observable<String> {
        return repo.observeMessage()
    }
}
