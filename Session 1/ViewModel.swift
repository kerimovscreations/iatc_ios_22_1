//
//  ViewModel.swift
//  Session 1
//
//  Created by Karim Karimov on 18.06.22.
//

import Foundation
import RxSwift
import RxRelay

class ViewModel {
    
    private let stateIterator: StateIteratorProtocol = StateIterator()
    
    private lazy var stateSubject: BehaviorSubject<TimerState> = {
        return BehaviorSubject<TimerState>.init(value: self.stateIterator.getCurrent())
    }()
    
    private lazy var remainingTimeRelay: BehaviorRelay<Int> = {
        return BehaviorRelay<Int>.init(value: self.stateIterator.getCurrent().getTimePeriod() * 60)
    }()
    
    private let timerRunningRelay: BehaviorRelay<TimerRunningState> = BehaviorRelay<TimerRunningState>.init(value: .paused)
    
    init() {
        self.stateIterator.update { state in
            self.stateSubject.on(.next(state))
            self.remainingTimeRelay.accept(self.stateIterator.getCurrent().getTimePeriod() * 60
            )
        }
    }
    
    func observeState() -> Observable<TimerState> {
        return self.stateSubject.asObservable()
    }
    
    func next(pauseTimer: Bool) {
        if pauseTimer {
            self.timerPause()
        }
        self.stateIterator.next()
    }
    
    func togglePlay() {
        let isRunning = self.timerRunningRelay.value
        
        switch isRunning {
        case .paused:
            self.timerStart()
        case .running:
            self.timerPause()
        }
    }
    
    // return remaining seconds
    func observeTimeRemaining() -> Observable<Int>{
        return self.remainingTimeRelay.asObservable()
    }
    
    func observeTimerRunning() -> Observable<TimerRunningState> {
        return self.timerRunningRelay.asObservable()
    }
    
    // MARK: - Timer
    
    private func createHeartBeatObservable(interval: Int) -> Observable<Data> {
        return Observable<Data>.create { observer in
            let timer = DispatchSource.makeTimerSource(queue: DispatchQueue.global())
            timer.schedule(deadline: DispatchTime.now(), repeating: .milliseconds(interval))
            
            let cancel = Disposables.create {
                timer.cancel()
            }
            
            timer.setEventHandler {
                if cancel.isDisposed {
                    return
                }
                observer.on(.next(Data()))
            }
            
            timer.resume()
            
            return cancel
        }
    }
    
    private var timerSubscription: Disposable? = nil
    
    private func timerStart() {
        self.timerSubscription?.dispose()
        
        self.timerRunningRelay.accept(.running)
        
        let heartBeatObservable = self.createHeartBeatObservable(interval: 100)
        
        self.timerSubscription = heartBeatObservable.subscribe { _ in
            let remaining = self.remainingTimeRelay.value - 1
            
            if remaining >= 0 {
                self.remainingTimeRelay.accept(remaining)
            } else {
                self.next(pauseTimer: false)
            }
        }
    }
    
    private func timerPause() {
        self.timerSubscription?.dispose()
        self.timerRunningRelay.accept(.paused)
    }
}

enum TimerState {
    case focus, short_break, long_break
    
    // in minutes
    func getTimePeriod() -> Int {
        switch self {
        case .focus:
            return 5
        case .short_break:
            return 1
        case .long_break:
            return 3
        }
    }
}

enum TimerRunningState {
    case paused, running
}

protocol StateIteratorProtocol {
    func getCurrent() -> TimerState
    func next()
    func update(on: @escaping (TimerState) -> Void)
}

class StateIterator: StateIteratorProtocol {
    
    private var breakCounter = 0
    
    private var currentState: TimerState = .focus {
        didSet {
            self.onUpdate(currentState)
        }
    }
    
    private var onUpdate: (TimerState) -> Void = { _ in }
    
    func getCurrent() -> TimerState {
        return self.currentState
    }
    
    // [focus short_br focus short_br focus long_br]
    func next() {
        switch self.currentState {
        case .focus:
            switch breakCounter % 3 {
            case 0, 1:
                self.currentState = .short_break
                self.breakCounter += 1
            case 2:
                self.currentState = .long_break
                self.breakCounter += 1
            default:
                break
            }
        case .short_break:
            self.currentState = .focus
        case .long_break:
            self.currentState = .focus
        }
    }
    
    func update(on: @escaping (TimerState) -> Void) {
        self.onUpdate = on
    }
}
