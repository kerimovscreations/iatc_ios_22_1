//
//  ViewController.swift
//  Session 1
//
//  Created by Karim Karimov on 05.04.22.
//

import UIKit
import SnapKit
import RxSwift

class ViewController: UIViewController {
    
    // MARK: - UI Components
    
    private lazy var label: UILabel = {
        let label = UILabel()
        
        self.view.addSubview(label)
        label.textColor = .black
        label.font = .systemFont(ofSize: 36)
        label.numberOfLines = 0
        
        return label
    }()
    
    // MARK: - Variables
    
    private let vm = ViewModel()
    
    private var compositeDisposable = CompositeDisposable()
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Parent delegates
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        self.label.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(50)
            make.right.equalToSuperview().offset(-20)
        }
        
        self.vm.fetchUserData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.compositeDisposable = CompositeDisposable()
        self.compositeDisposable.disposed(by: self.disposeBag)
        
        let subscription = self.vm.observeState()
            .observe(on: MainScheduler.instance)
            .subscribe { received in
            guard let data = received.element else { return }
            
            switch data {
            case .show(let users):
                self.label.text = users.map({ user in
                    user.name
                }).joined(separator: ", ")
            }
        }
        
        self.add(subscription: subscription)
        
        let effectSubscription = self.vm.observeEffect()
            .observe(on: MainScheduler.instance)
            .subscribe { received in
                guard let effect = received.element else { return }
                
                print(effect)
                
                switch effect {
                case .error(let err):
                    let alert = UIAlertController(title: "Error", message: "Unexpected error occurred: \(err.localizedDescription)", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Close", style: .cancel))
                    self.present(alert, animated: true)
                }
            }
        
        self.add(subscription: effectSubscription)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.compositeDisposable.dispose()
    }
    
    private func add(subscription: Disposable) {
        let _ = self.compositeDisposable.insert(subscription)
    }
}
