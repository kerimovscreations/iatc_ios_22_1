//
//  ViewController.swift
//  Session 1
//
//  Created by Karim Karimov on 05.04.22.
//

import UIKit
import SnapKit
import Alamofire
import Promises
import RxSwift
import RxRelay

class ViewController: UIViewController {
    
    var disposeBag: DisposeBag? = DisposeBag()
    var compositeBag = CompositeDisposable()
    
    let bs = BehaviorSubject<[String]>.init(value: ["2323"])
    
    private lazy var btn: UIButton = {
        let btn = UIButton()
        
        btn.setTitle("Add", for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        return btn
    }()
    
    private lazy var removeBtn: UIButton = {
        let btn = UIButton()
        
        btn.setTitle("Remove", for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        compositeBag.disposed(by: disposeBag!)
        
        
//        subscription.disposed(by: disposeBag)
        
        self.view.addSubview(btn)
        btn.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(20)
            make.centerX.equalTo(self.view.snp.centerX)
        }
        
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(onClick))
        self.btn.addGestureRecognizer(tapGesture)
        
        self.view.addSubview(removeBtn)
        removeBtn.snp.makeConstraints { make in
            make.top.equalTo(self.btn.snp.bottom).offset(20)
            make.centerX.equalTo(self.view.snp.centerX)
        }
        
        let removetapGesture = UITapGestureRecognizer.init(target: self, action: #selector(onRemove))
        self.removeBtn.addGestureRecognizer(removetapGesture)
    }
    
    
    
    
    @objc func onClick() {
        let intervalObs = self.myInterval(.seconds(1))
            .share(replay: 2)
        
        let subscription1 = intervalObs
            .myMap(transform: { value in
                return value * 10
            })
            .scan(into: 2, accumulator: { past, next in
                past = past * next
            })
            .buffer(timeSpan: .seconds(2), count: 2, scheduler: MainScheduler.instance)
            .subscribe { received in
            if let value = received.element {
                print("Subscriber 1: \(value)")
            }
            
        }
        let _ = compositeBag.insert(subscription1)
        
        let subscription2 = intervalObs.subscribe { received in
            if let value = received.element {
                print("Subscriber 2: \(value)")
            }
            
        }
        let _ = compositeBag.insert(subscription2)
        
        Thread.sleep(forTimeInterval: 5)
        
        subscription1.dispose()
        
        Thread.sleep(forTimeInterval: 3.5)
        
        let subscription3 = intervalObs.subscribe { received in
            if let value = received.element {
                print("Subscriber 3: \(value)")
            }
            
        }
        let _ = compositeBag.insert(subscription3)
        
        Thread.sleep(forTimeInterval: 3)
        
        subscription2.dispose()
        subscription3.dispose()
    }
    
    @objc func onRemove() {
        print("compositeBag.count: \(compositeBag.count)")
        
        compositeBag.dispose()
        
        
        compositeBag = CompositeDisposable()
        
        compositeBag.disposed(by: disposeBag!)
    }
    
    func justMy<E>(_ element: E) -> Observable<E> {
        return Observable.create { observer in
            observer.on(.next(element))
            observer.on(.completed)
            return Disposables.create()
        }
    }
    
    func myList<E>(_ elements: [E]) -> Observable<E> {
        return Observable.create { observer in
            for element in elements {
                observer.on(.next(element))
            }
            
            observer.on(.completed)
            
            return Disposables.create()
        }
    }
    
    func myInterval(_ interval: DispatchTimeInterval) -> Observable<Int> {
        return Observable.create { observer in
            print("Subscribed")
            
            let timer = DispatchSource.makeTimerSource(queue: DispatchQueue.global())
            timer.schedule(deadline: DispatchTime.now() + interval, repeating: interval)
            
            let cancel = Disposables.create {
                print("Disposed")
                timer.cancel()
            }
            
            var next = 1
            timer.setEventHandler {
                if cancel.isDisposed {
                    return
                }
                observer.on(.next(next))
                next += 1
            }
            timer.resume()
            
            return cancel
        }
    }
}

extension ObservableType {
    func myMap<R>(transform: @escaping (Element) -> R) -> Observable<R> {
        return Observable.create { observer in
            let subscription = self.subscribe { e in
                    switch e {
                    case .next(let value):
                        let result = transform(value)
                        observer.on(.next(result))
                    case .error(let error):
                        observer.on(.error(error))
                    case .completed:
                        observer.on(.completed)
                    }
                }

            return subscription
        }
    }
}
