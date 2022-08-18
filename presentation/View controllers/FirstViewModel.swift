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
    
    public init(
        getUserUseCase: GetUserUseCase,
        syncUserUseCase: SyncUserUseCase,
        observeUserUseCase: ObserveUserUseCase
    ) {
        self.getUserUseCase = getUserUseCase
        self.syncUserUseCase = syncUserUseCase
        self.observeUserUseCase = observeUserUseCase
    }
    
    func getUser() -> Promise<UserEntity> {
        let useCase = self.getUserUseCase
        
        return useCase.execute()
    }
    
    func observeUser() -> Observable<UserEntity> {
        return self.observeUserUseCase.execute()
    }
    
    func syncUser() {
        self.syncUserUseCase.execute()
    }
}
