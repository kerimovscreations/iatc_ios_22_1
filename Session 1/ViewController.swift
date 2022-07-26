//
//  ViewController.swift
//  Session 1
//
//  Created by Karim Karimov on 05.04.22.
//

import UIKit
import SnapKit
import Swinject

class ViewController: UIViewController {
    
    // MARK: - Variables
    
    private let vm = ViewModel()
    
    // MARK: - Parent delegates
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        self.vm.testDI()
    }
}
