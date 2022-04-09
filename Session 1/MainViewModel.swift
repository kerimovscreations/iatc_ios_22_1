//
//  MainViewModel.swift
//  Session 1
//
//  Created by Karim Karimov on 09.04.22.
//

import Foundation

class MainViewModel {
    private let carRepo = CarRepository()
    
    func getCars() -> [Car] {
        return self.carRepo.getCars()
    }
}
