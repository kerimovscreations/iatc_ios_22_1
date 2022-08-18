//
//  AppDelegate.swift
//  Session 1
//
//  Created by Karim Karimov on 05.04.22.
//

import UIKit
import presentation
import Swinject
import domain
import data

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Override point for customization after application launch.
        
        let assembler = Assembler([
            DomainAssembly(),
            PresentationAssembly(),
            DataAssembly()
        ])
        
        let router: RouterProtocol = Router.init(resolver: assembler.resolver)
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let vc = router.firstViewController()
        self.window?.rootViewController = vc
        self.window?.makeKeyAndVisible()
        
        return true
    }
}

