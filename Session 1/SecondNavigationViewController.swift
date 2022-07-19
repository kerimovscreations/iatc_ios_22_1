//
//  SecondNavigationViewController.swift
//  Session 1
//
//  Created by Karim Karimov on 19.07.22.
//

import UIKit

class SecondNavigationViewController: UINavigationController, UIGestureRecognizerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vc = SecondViewController()

        self.viewControllers = [ vc ]
        
        interactivePopGestureRecognizer?.delegate = self
        interactivePopGestureRecognizer?.isEnabled = true
        
        
        navigationBar.prefersLargeTitles = true
        vc.navigationItem.title = "Second"
    }

}
