//
//  FirstViewModel.swift
//  presentation
//
//  Created by Karim Karimov on 30.07.22.
//

import Foundation
import domain
import Promises
import RxSwift

public class FirstViewModel {
    
    private let getUserUseCase: GetUserUseCase
    private let syncUserUseCase: SyncUserUseCase
    private let observeUserUseCase: ObserveUserUseCase
    private let sendMessageUseCase: SendSocketMessageUseCase
    private let observeMessageUseCase: ObserveSocketMessageUseCase
    
    public init(
        getUserUseCase: GetUserUseCase,
        syncUserUseCase: SyncUserUseCase,
        observeUserUseCase: ObserveUserUseCase,
        sendMessageUseCase: SendSocketMessageUseCase,
        observeMessageUseCase: ObserveSocketMessageUseCase
    ) {
        self.getUserUseCase = getUserUseCase
        self.syncUserUseCase = syncUserUseCase
        self.observeUserUseCase = observeUserUseCase
        self.sendMessageUseCase = sendMessageUseCase
        self.observeMessageUseCase = observeMessageUseCase
    }
    
    func getUser() -> Promise<UserEntity> {
        let useCase = self.getUserUseCase
        
        return useCase.execute()
    }
    
    func observeUser() -> Observable<UserEntity> {
        return self.observeUserUseCase.execute()
    }
    
    func syncUser() {
        let _ = self.syncUserUseCase.execute()
    }
    
    func send(message: String) {
        self.sendMessageUseCase.execute(message: message)
    }
    
    func observeMessage() -> Observable<String> {
        return self.observeMessageUseCase.execute()
    }
}
