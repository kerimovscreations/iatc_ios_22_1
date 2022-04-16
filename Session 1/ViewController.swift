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
    
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        self.view.addSubview(label)
        
        label.font = UIFont.systemFont(ofSize: 40, weight: .bold)
        label.textColor = .darkText
        label.textAlignment = .center
        
        label.text = "Let's you in"
        
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        
        self.view.addSubview(view)
        
        view.axis = .vertical

        view.distribution = .equalSpacing
        view.spacing = 16
        
        return view
    }()
    
    private lazy var orLabel: UILabel = {
        let label = UILabel()
        
        self.view.addSubview(label)
        
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .darkText
        label.textAlignment = .center
        
        label.text = "or"
        
        return label
    }()
    
    private lazy var loginBtn: UIButton = {
        let btn = UIButton()
        
        self.view.addSubview(btn)
        
        btn.backgroundColor = .systemGreen
        btn.layer.cornerRadius = 25
        btn.setTitle("Sign in with password", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        
        return btn
    }()
    
    // MARK: - Parent delegates

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        self.titleLabel.snp.makeConstraints { make in
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left).offset(40)
            make.right.equalTo(self.view.safeAreaLayoutGuide.snp.right).offset(-40)
            make.bottom.equalTo(self.stackView.snp.top).offset(-80)
        }
        
        self.stackView.snp.makeConstraints { make in
            make.center.equalTo(self.view.center)
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left).offset(16)
        }
        
        self.stackView.addArrangedSubview(
            self.getButton(
                title: "Continue with Facebook",
                icon: UIImage(named: "ic_facebook"))
        )
        
        self.stackView.addArrangedSubview(
            self.getButton(
                title: "Continue with Google",
                icon: UIImage(named: "ic_google"))
        )
        
        self.stackView.addArrangedSubview(
            self.getButton(
                title: "Continue with Apple",
                icon: UIImage(named: "ic_apple"))
        )
        
        self.orLabel.snp.makeConstraints { make in
            make.top.equalTo(self.stackView.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
        }
        
        self.loginBtn.snp.makeConstraints { make in
            make.top.equalTo(self.orLabel.snp.bottom).offset(40)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(50)
        }
    }
    
    // MARK: - Method
    
    func getButton(title: String, icon: UIImage?) -> UIView {
        let view = UIView()
        
        view.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.cornerRadius = 12
        
        let label = UILabel()
        
        view.addSubview(label)
        
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = .darkText
        label.text = title
        
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        let image = UIImageView(image: icon)
        
        view.addSubview(image)
        
        image.snp.makeConstraints { make in
            make.width.height.equalTo(24)
            make.right.equalTo(label.snp.left).offset(-12)
            make.centerY.equalTo(view.snp.centerY)
        }
        
        return view
    }
}
