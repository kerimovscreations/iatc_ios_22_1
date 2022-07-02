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
        
//        self.vm.seedData()
        
//        self.vm.getRestaurants()
        
//        self.vm.countCheaperRestaurants()
        
//        self.vm.countCheaperRestaurants2()
        
//        self.vm.sumMidPrices()
        
//        self.vm.sortedByName()
        
//        self.vm.sortedByDistance()
        
//        self.vm.asyncFetchAllRestaurants()
        
//        self.vm.batchUpdateDistance()
//
//        self.vm.sortedByDistance()
//
//        self.vm.sumMidPrices()
        
        self.vm.batchDelete()
    }
}
