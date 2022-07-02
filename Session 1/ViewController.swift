//
//  ViewController.swift
//  Session 1
//
//  Created by Karim Karimov on 05.04.22.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    // MARK: - UI Components
    
    
    // MARK: - Variables
    
    private let vm = ViewModel()
    
    
    // MARK: - Parent delegates
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
//        vm.addV1Data()
//        self.vm.addImages()
        
        
        self.vm.read()
        self.vm.readAttachments()
    }
}
