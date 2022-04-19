//
//  ViewController.swift
//  Session 1
//
//  Created by Karim Karimov on 05.04.22.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    private let vm = MainViewModel()
    
        
    // MARK: - UI Components
    
    private lazy var toolbarView : ToolbarView = {
        let view = ToolbarView()
        self.view.addSubview(view)
        return view
    }()
    
    private lazy var scrollView : UIScrollView = {
        let view = UIScrollView()
        self.view.addSubview(view)
        
        view.backgroundColor = UIColor.init(white: 0.98, alpha: 1.0)
        
        return view
    }()
    
    private lazy var stackView : UIStackView = {
        let view = UIStackView()
        self.scrollView.addSubview(view)
        view.axis = .vertical
        view.distribution = .equalSpacing
        view.spacing = 16
        return view
    }()
    
    let houses: [House] = [
        House(title: "house1 house1 house1 house1", price: "100$", description: "description1", rating: 1.9, ratingCount: 15),
        House(title: "house2", price: "200$", description: "description2", rating: 3.9, ratingCount: 100),
        House(title: "house3", price: "300$", description: "description3",rating: 5.0, ratingCount: 105),
        House(title: "house1 house1 house1 house1", price: "100$", description: "description1", rating: 1.9, ratingCount: 15),
        House(title: "house2", price: "200$", description: "description2", rating: 3.9, ratingCount: 100),
        House(title: "house3", price: "300$", description: "description3",rating: 5.0, ratingCount: 105),
        House(title: "house1 house1 house1 house1", price: "100$", description: "description1", rating: 1.9, ratingCount: 15),
        House(title: "house2", price: "200$", description: "description2", rating: 3.9, ratingCount: 100),
        House(title: "house3", price: "300$", description: "description3",rating: 5.0, ratingCount: 105)
    ]
    // MARK: - Parent delegates

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        toolbarView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left)
            make.right.equalTo(self.view.safeAreaLayoutGuide.snp.right)
            make.height.equalTo(54)
        }
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(self.toolbarView.snp.bottom)
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left)
            make.right.equalTo(self.view.safeAreaLayoutGuide.snp.right)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(self.scrollView.contentLayoutGuide.snp.top).offset(16)
            make.left.equalTo(self.scrollView.contentLayoutGuide.snp.left).offset(16)
            make.centerX.equalTo(self.scrollView.snp.centerX)
            make.bottom.equalTo(self.scrollView.contentLayoutGuide.snp.bottom).offset(-16)
        }
        
        self.houses.forEach { house in
            let houseView = HouseListView()
            houseView.setup(house: house)
            self.stackView.addArrangedSubview(houseView)
        }
    }
    
    
}

struct House {
    let title: String
    let price: String
    let description: String
    let rating: Double
    let ratingCount: Int
}
