//
//  Router.swift
//  presentation
//
//  Created by Karim Karimov on 30.07.22.
//

import Foundation
import Swinject
import domain

public protocol RouterProtocol {
    func firstViewController() -> FirstViewController
}

public class Router: RouterProtocol {
    
    private let resolver: Resolver
    
    public init(resolver: Resolver) {
        self.resolver = resolver
    }
    
    public func firstViewController() -> FirstViewController {
        let vc = FirstViewController()
        
        vc.vm = resolver.resolve(FirstViewModel.self)!
        vc.router = self
        
        return vc
    }
}
