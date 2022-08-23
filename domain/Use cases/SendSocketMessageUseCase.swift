//
//  SendSocketMessageUseCase.swift
//  domain
//
//  Created by Karim Karimov on 23.08.22.
//

import Foundation
import Promises

public class SendSocketMessageUseCase {
    
    private let repo: UserRepoProtocol
    
    init(repo: UserRepoProtocol) {
        self.repo = repo
    }
    
    public func execute(message: String) {
        return repo.send(message: message)
    }
}
