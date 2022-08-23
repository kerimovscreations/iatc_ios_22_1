//
//  FirstViewController.swift
//  presentation
//
//  Created by Karim Karimov on 30.07.22.
//

import UIKit
import RxSwift
import SnapKit

public class FirstViewController: BaseViewController<FirstViewModel> {
    
    private var userSubscription: Disposable? = nil
    private var socketSubscription: Disposable? = nil
    
    private var disposeBag = DisposeBag()
    
    private lazy var sendBtn: UIButton = {
        let btn = UIButton()
        
        btn.setTitle("Send phew", for: .normal)
        
        btn.addTarget(self, action: #selector(onClick), for: .touchUpInside)
        
        self.view.addSubview(btn)
        
        return btn
    }()

    public override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .systemBlue
        
        self.sendBtn.snp.makeConstraints { make in
            make.center.equalTo(self.view.snp.center)
        }
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.vm?.syncUser()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        userSubscription = self.vm?.observeUser().subscribe({ received in
            guard let data = received.element else { return }
            
            print(data.email)
        })
        
        socketSubscription = self.vm?.observeMessage().subscribe({ received in
            guard let message = received.element else { return }
            
            print("message received in UI \(message)")
        })
        
        userSubscription?.disposed(by: self.disposeBag)
        socketSubscription?.disposed(by: self.disposeBag)
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        userSubscription?.dispose()
        socketSubscription?.dispose()
    }
    
    @objc func onClick() {
        self.vm?.send(message: "phew")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
