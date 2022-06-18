//
//  PlayerControlView.swift
//  Session 1
//
//  Created by Karim Karimov on 18.06.22.
//

import Foundation
import UIKit
import SnapKit

class PlayerControlView: UIView {
    
    // MARK: - UI Components
    
    private lazy var leftIcon: UIView = {
        let view = UIView()
        
        self.addSubview(view)
        
        view.roundCorner(radius: 24)
        
        view.backgroundColor = .lightGray
        
        let imageIcon = UIImageView(image: UIImage(named: "ic_more"))
        
        imageIcon.contentMode = .scaleAspectFit
        
        view.addSubview(imageIcon)
        
        imageIcon.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        let tapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(onLeft))
        view.addGestureRecognizer(tapGestureRecognizer)
        
        return view
    }()
    
    private var centerIconImage: UIImageView? = nil
    
    private lazy var centerIcon: UIView = {
        let view = UIView()
        
        self.addSubview(view)
        
        view.roundCorner(radius: 32)
        
        view.backgroundColor = .lightGray
        
        centerIconImage = UIImageView(image: UIImage(named: "ic_play"))
        
        centerIconImage!.contentMode = .scaleAspectFit
        
        view.addSubview(centerIconImage!)
        
        centerIconImage!.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        let tapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(onCenter))
        view.addGestureRecognizer(tapGestureRecognizer)
        
        return view
    }()
    
    private lazy var rightIcon: UIView = {
        let view = UIView()
        
        self.addSubview(view)
        
        view.roundCorner(radius: 24)
        
        view.backgroundColor = .lightGray
        
        let imageIcon = UIImageView(image: UIImage(named: "ic_next"))
        
        imageIcon.contentMode = .scaleAspectFit
        
        view.addSubview(imageIcon)
        
        imageIcon.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        let tapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(onRight))
        view.addGestureRecognizer(tapGestureRecognizer)
        
        return view
    }()
    
    // MARK: - Variable
    
    var delegate: PlayerControlDelegate? = nil
    
    // MARK: - Parent delegates
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupView()
        
    }
    
    private func setupView() {
        self.leftIcon.snp.makeConstraints { make in
            make.width.height.equalTo(80)
            make.right.equalTo(self.centerIcon.snp.left).offset(-16)
            make.left.equalToSuperview()
            make.centerY.equalTo(self.centerIcon.snp.centerY)
        }
        
        self.rightIcon.snp.makeConstraints { make in
            make.width.height.equalTo(80)
            make.left.equalTo(self.centerIcon.snp.right).offset(16)
            make.right.equalToSuperview()
            make.centerY.equalTo(self.centerIcon.snp.centerY)
        }
        
        self.centerIcon.snp.makeConstraints { make in
            make.width.equalTo(128)
            make.height.equalTo(96)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
        }
    }
    
    func setup(state: TimerState) {
        // setup UI
    }
    
    func setup(runningState: TimerRunningState) {
        switch runningState {
        case .running:
            self.centerIconImage?.image = UIImage(named: "ic_pause")
        case .paused:
            self.centerIconImage?.image = UIImage(named: "ic_play")
        }
    }
    
    @objc func onLeft() {
        self.delegate?.onMore()
    }
    
    @objc func onRight() {
        self.delegate?.onNext()
    }
    
    @objc func onCenter() {
        self.delegate?.onPlay()
    }
}

protocol PlayerControlDelegate {
    func onMore()
    func onPlay()
    func onNext()
}

extension UIView {
    func roundCorner(radius: Int) {
        self.layer.cornerRadius = CGFloat(radius)
        self.clipsToBounds = true
    }
}
