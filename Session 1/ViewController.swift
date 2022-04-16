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
    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        
        view.backgroundColor = .darkGray
        
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        
        view.backgroundColor = .lightGray
        
        view.axis = .vertical
        view.distribution = .equalSpacing
        view.spacing = 16
        
        return view
    }()
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        
        label.numberOfLines = 0
        
        label.backgroundColor = .lightGray
        
        label.textColor = .black
        
        label.font = UIFont.systemFont(ofSize: 24)
        
        label.textAlignment = .center
                
        return label
    }()
    
    private lazy var textLabel2: UILabel = {
        let label = UILabel()
        
        label.numberOfLines = 0
        
        label.backgroundColor = .lightGray
        
        label.textColor = .black
        
        label.font = UIFont.systemFont(ofSize: 18)
        
        label.textAlignment = .left
                
        return label
    }()
    
    // MARK: - Parent delegates

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
//        self.view.addSubview(self.redView)
//
//        self.redView.snp.makeConstraints { make in
//            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left).offset(20)
//            make.right.equalTo(self.view.safeAreaLayoutGuide.snp.right).offset(-20)
//            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(20)
//            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-20)
//        }
//
//        self.redView.addSubview(self.textLabel)
//
//        self.textLabel.snp.makeConstraints { make in
//            make.bottom.equalTo(self.redView.snp.centerY)
//            make.right.equalTo(self.redView.snp.centerX).offset(-8)
//            make.left.equalToSuperview().offset(16)
//        }
//
        let shortText = "Swift Package Manager Swift Package Manager\nSwift Package Manager Swift Package Manager\nSwift Package Manager Swift Package Manager\nSwift Package Manager Swift Package Manager\nSwift Package Manager Swift Package Manager\nSwift Package Manager Swift Package Manager\nSwift Package Manager Swift Package Manager\nSwift Package Manager Swift Package Manager\nSwift Package Manager Swift Package Manager\nSwift Package Manager Swift Package Manager"

        self.textLabel.text = shortText
//
//        self.redView.addSubview(self.textLabel2)
//
//        self.textLabel2.snp.makeConstraints { make in
//            make.bottom.equalTo(self.redView.snp.centerY)
//            make.left.equalTo(self.redView.snp.centerX).offset(8)
//            make.right.equalToSuperview().offset(-16)
//        }
//
        self.textLabel2.text = "Swift Package Manager Description Description\nSwift Package Manager Description Description\nSwift Package Manager Description Description\nSwift Package Manager Description Description\nSwift Package Manager Description Description\nSwift Package Manager Description Description\nSwift Package Manager Description Description\n"
        
        
        self.view.addSubview(self.scrollView)
        
        self.scrollView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left)
            make.right.equalTo(self.view.safeAreaLayoutGuide.snp.right)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
        
        self.scrollView.addSubview(self.stackView)
        
        self.stackView.snp.makeConstraints { make in
            make.top.equalTo(self.scrollView.contentLayoutGuide.snp.top).offset(16)
            make.bottom.equalTo(self.scrollView.contentLayoutGuide.snp.bottom).offset(-16)
            make.left.equalTo(self.scrollView.contentLayoutGuide.snp.left).offset(16)
            make.centerX.equalTo(self.scrollView.snp.centerX)
        }
        
        self.stackView.addArrangedSubview(self.textLabel)
        self.stackView.addArrangedSubview(self.textLabel2)
    }
}
