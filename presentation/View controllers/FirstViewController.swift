//
//  FirstViewController.swift
//  presentation
//
//  Created by Karim Karimov on 30.07.22.
//

import UIKit
import RxSwift

public class FirstViewController: BaseViewController<FirstViewModel> {
    
    private var userSubscription: Disposable? = nil
    
    private var disposeBag = DisposeBag()

    public override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .systemBlue
        
//        self.vm?.getUser().then({ user in
//            print(user.email)
//        })
        
        
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.vm?.syncUser()
        self.vm?.syncUser()
        self.vm?.syncUser()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        userSubscription = self.vm?.observeUser().subscribe({ received in
            guard let data = received.element else { return }
            
            print(data.email)
        })
        
        userSubscription?.disposed(by: self.disposeBag)
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        userSubscription?.dispose()
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
