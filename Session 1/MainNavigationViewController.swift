//
//  MainNavigationViewController.swift
//  Session 1
//
//  Created by Karim Karimov on 19.07.22.
//

import UIKit

class MainNavigationViewController: UINavigationController, UIGestureRecognizerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        let vc = ViewController()
        
        self.viewControllers = [vc]
        
        interactivePopGestureRecognizer?.delegate = self
        interactivePopGestureRecognizer?.isEnabled = true
    }

}
