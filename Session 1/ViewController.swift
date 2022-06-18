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
    
    private lazy var chipIcon: UIImageView = {
        let icon = UIImageView.init(image: UIImage.init(named: "ic_chip_focus"))
        
        self.view.addSubview(icon)
        
        icon.contentMode = .scaleAspectFill
        
        return icon
    }()
    
    private lazy var playerControl: PlayerControlView = {
        let view = PlayerControlView()
        
        self.view.addSubview(view)
        
        return view
    }()
    
    private lazy var timerWrapperView: UIView = {
        let view = UIView()
        
        self.view.addSubview(view)
        
        view.clipsToBounds = true
        
        return view
    }()
    
    private lazy var timerText: UILabel = {
        let label = UILabel()
        
        self.timerWrapperView.addSubview(label)
        
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        
        return label
    }()
    
    // MARK: - Variables
    
    private let fontProvider = FontProvider()
    
    private let vm = ViewModel()
    
    private var compositeDisposable = CompositeDisposable()
    
    // MARK: - Parent delegates
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        self.setupUI()
        
        self.playerControl.delegate = self
    }
    
    private func setupUI() {
        self.chipIcon.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(48)
            make.height.equalTo(48)
        }
        
        self.playerControl.snp.makeConstraints { make in
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-48)
            make.centerX.equalToSuperview()
        }
        
        self.timerWrapperView.snp.makeConstraints { make in
            make.top.equalTo(self.chipIcon.snp.bottom).offset(32)
            make.bottom.equalTo(self.playerControl.snp.top).offset(-32)
            make.centerX.equalToSuperview()
        }
        
        self.timerText.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(24)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
    }
    
    private func setState(_ state: TimerState) {
        switch state {
        case .focus:
            self.chipIcon.image = UIImage.init(named: "ic_chip_focus")
        case .short_break:
            self.chipIcon.image = UIImage.init(named: "ic_chip_short_break")
        case .long_break:
            self.chipIcon.image = UIImage.init(named: "ic_chip_long_break")
        }
    }
    
    private func setRemainingTime(_ time: Int) {
        let minutes: Int = time / 60
        let seconds: Int = time % 60
        
        let timerContent = String.init(format: "%02d\n%02d", minutes, seconds)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.83
        
        self.timerText.textAlignment = .center
        self.timerText.attributedText = NSMutableAttributedString(
            string: timerContent, attributes: [
                NSAttributedString.Key.paragraphStyle: paragraphStyle,
                NSAttributedString.Key.font: fontProvider.getFont(type: .timer_pause),
                NSAttributedString.Key.foregroundColor: UIColor.black
            ])
    }
    
    private func setRunningState(_ state: TimerRunningState) {
        self.playerControl.setup(runningState: state)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.compositeDisposable = CompositeDisposable()
        
        let stateSubscription = self.vm.observeState()
            .observe(on: MainScheduler.instance)
            .subscribe { received in
            guard let state = received.element else { return }
            
            self.setState(state)
        }
        
        let _ = self.compositeDisposable.insert(stateSubscription)
        
        let timerSubscription = self.vm.observeTimeRemaining()
            .observe(on: MainScheduler.instance)
            .subscribe { received in
                guard let time = received.element else { return }
                
                self.setRemainingTime(time)
            }
        
        let _ = self.compositeDisposable.insert(timerSubscription)
        
        let timerRunningSubscription = self.vm.observeTimerRunning()
            .observe(on: MainScheduler.instance)
            .subscribe { received in
            guard let state = received.element else { return }
            
            self.setRunningState(state)
        }
        
        let _ = self.compositeDisposable.insert(timerRunningSubscription)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.compositeDisposable.dispose()
    }
}

// MARK: - Player control delegate

extension ViewController: PlayerControlDelegate {
    func onMore() {
        // break
    }
    
    func onPlay() {
        self.vm.togglePlay()
    }
    
    func onNext() {
        self.vm.next(pauseTimer: true)
    }
}
