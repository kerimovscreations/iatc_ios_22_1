//
//  ViewController.swift
//  Session 1
//
//  Created by Karim Karimov on 05.04.22.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    // MARK: - Variables
    
    private lazy var victimView: UIView = {
        let view = UIView()
        
        self.view.addSubview(view)
        
        view.backgroundColor = .systemBlue
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        
        return view
    }()
    
    private var horizontalTranslation = 0
    
    // MARK: - UI Components
    
    // MARK: - Parent delegates

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        self.victimView.snp.makeConstraints { make in
            make.center.equalTo(self.view.snp.center)
            make.width.equalTo(300)
            make.height.equalTo(200)
        }
        
        // tap gesture recognizer
        
//        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(onTap(_:)))
//        tapRecognizer.numberOfTapsRequired = 2
//        self.victimView.addGestureRecognizer(tapRecognizer)
        
        // pinch gesture recognizer
        
//        let pinchRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(onPinch(_:)))
//        self.victimView.addGestureRecognizer(pinchRecognizer)
        
        // rotation gesture recognizer
        
//        let rotateRecognizer = UIRotationGestureRecognizer(target: self, action: #selector(onRotate(_:)))
//        self.victimView.addGestureRecognizer(rotateRecognizer)
        
        // swipe gesture recognizer
        
//        let swipeLeftRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(onSwipe(_:)))
//        swipeLeftRecognizer.direction = .left
//        self.victimView.addGestureRecognizer(swipeLeftRecognizer)
//
//        let swipeRightRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(onSwipe(_:)))
//        swipeRightRecognizer.direction = .right
//        self.victimView.addGestureRecognizer(swipeRightRecognizer)
        
        // pan gesture recognizer
        
//        let panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(onPan(_:)))
//        self.victimView.addGestureRecognizer(panRecognizer)
        
        // edge pan gesture recognizer
        
//        let leftEdgePanRecognizer = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(onEdgePan(_:)))
//        leftEdgePanRecognizer.edges = .left
//        self.view.addGestureRecognizer(leftEdgePanRecognizer)
//
//        let rightEdgePanRecognizer = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(onEdgePan(_:)))
//        rightEdgePanRecognizer.edges = .right
//        self.view.addGestureRecognizer(rightEdgePanRecognizer)
        
        // long press gesture recognizer
        
//        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(onLongPress(_:)))
//        longPressRecognizer.minimumPressDuration = 2
//        self.victimView.addGestureRecognizer(longPressRecognizer)
    }
    
    // MARK: - Functions
    
    @objc func onTap(_ sender: UITapGestureRecognizer) {
        if sender.state == .recognized {
            print("Recognized")

            let transform = CGAffineTransform.init(scaleX: 1.2, y: 1.2)
            self.victimView.transform = transform
        }
    }
    
    @objc func onPinch(_ sender: UIPinchGestureRecognizer) {
        if sender.state == UIGestureRecognizer.State.changed {
            let transform = CGAffineTransform.init(scaleX: sender.scale, y: sender.scale)
            self.victimView.transform = transform
        }
    }
    
    @objc func onRotate(_ sender: UIRotationGestureRecognizer) {
        if sender.state == UIGestureRecognizer.State.changed {
            let transform = CGAffineTransform.init(rotationAngle: sender.rotation)
            self.victimView.transform = transform
        }
    }
    
    @objc func onSwipe(_ sender: UISwipeGestureRecognizer) {
        if sender.direction == .right {
            self.horizontalTranslation += 10
            let transform = CGAffineTransform.init(translationX: CGFloat(self.horizontalTranslation), y: 0)
            self.victimView.transform = transform
        } else if sender.direction == .left {
            self.horizontalTranslation -= 10
            let transform = CGAffineTransform.init(translationX: CGFloat(self.horizontalTranslation), y: 0)
            self.victimView.transform = transform
        }
    }
    
    @objc func onPan(_ sender: UIPanGestureRecognizer) {
        if sender.state == .changed {
            let translation = sender.translation(in: self.view)
            let transform = CGAffineTransform.init(translationX: translation.x, y: translation.y)
            self.victimView.transform = transform
        }
    }
    
    @objc func onEdgePan(_ sender: UIScreenEdgePanGestureRecognizer) {
        if sender.state == .recognized {
            if sender.edges == .left {
                self.horizontalTranslation += 10
                let transform = CGAffineTransform.init(translationX: CGFloat(self.horizontalTranslation), y: 0)
                self.victimView.transform = transform
            } else if sender.edges == .right {
                self.horizontalTranslation -= 10
                let transform = CGAffineTransform.init(translationX: CGFloat(self.horizontalTranslation), y: 0)
                self.victimView.transform = transform
            }
        }
    }
    
    @objc func onLongPress(_ sender: UILongPressGestureRecognizer) {
        if sender.state == .recognized {
            let transform = CGAffineTransform.init(scaleX: 1.2, y: 1.2)
            self.victimView.transform = transform
        }
    }
}
