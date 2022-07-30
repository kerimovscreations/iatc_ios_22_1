//
//  PresentationAssembly.swift
//  presentation
//
//  Created by Karim Karimov on 30.07.22.
//

import Foundation
import Swinject
import domain

public class PresentationAssembly: Assembly {
    
    public init() {
        
    }
    
    public func assemble(container: Container) {
        container.register(FirstViewModel.self) { r in
            FirstViewModel(
                getUserUseCase: r.resolve(GetUserUseCase.self)!,
                syncUserUseCase: r.resolve(SyncUserUseCase.self)!,
                observeUserUseCase: r.resolve(ObserveUserUseCase.self)!
            )
        }
    }
}
