//
//  ViewController.swift
//  Session 1
//
//  Created by Karim Karimov on 05.04.22.
//

import UIKit

class ViewController: UIViewController {
    
    private let vm = MainViewModel()
        
    // MARK: - UI Components
    
    private lazy var view1: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.layer.cornerRadius = 20
        
        view.frame = CGRect.init(x: 50, y: 50, width: 100, height: 100)
        
        let tapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(onClick))
        view.addGestureRecognizer(tapGestureRecognizer)
        view.isUserInteractionEnabled = true
        
        return view
    }()
    
    private lazy var btn1: UIButton = {
        let btn = UIButton()
        
        btn.setTitle("Button is enabled", for: .normal)
        btn.setTitle("Button is disabled", for: .disabled)
        
        btn.setTitleColor(UIColor.systemGreen, for: .normal)
        btn.setTitleColor(UIColor.gray, for: .disabled)
        
        btn.frame = CGRect.init(x: 50, y: 200, width: 150, height: 40)
        
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        
        btn.addTarget(self, action: #selector(onBtnClick), for: .touchUpInside)
        
        return btn
    }()
    
    private lazy var image1: UIImageView = {
        let imageView = UIImageView()
        
        imageView.image = UIImage.init(named: "bird")
        imageView.contentMode = .scaleAspectFit
        
        imageView.frame = CGRect.init(x: 50, y: 250, width: 100, height: 100)
        
        return imageView
    }()
    
    private lazy var slider1: UISlider = {
        let slider = UISlider()
        
        slider.frame = CGRect.init(x: 50, y: 380, width: 300, height: 30)
        
        slider.addTarget(self, action: #selector(onSliderChange(_:)), for: .valueChanged)
        
        return slider
    }()
    
    private lazy var stackView1: UIStackView = {
        let view = UIStackView()
        
        view.axis = .vertical
        view.distribution = .fillEqually
        view.spacing = 16
        
        view.frame = CGRect.init(
            x: 20,
            y: 40,
            width: self.view.frame.width - 40,
            height: 1000)
        
        view.backgroundColor = .lightGray
        
        return view
    }()
    
    private lazy var viewChild1: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBlue
        
        return view
    }()
    
    private lazy var viewChild2: UIView = {
        let view = UIView()
        view.backgroundColor = .systemRed
        
        return view
    }()
    
    private lazy var viewChild3: UIView = {
        let view = UIView()
        view.backgroundColor = .yellow
        
        return view
    }()
    
    private lazy var viewChild4: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBlue

        return view
    }()
    
    private lazy var viewChild5: UITextField = {
        let view = UITextField()
        
        view.placeholder = "Write here"
        
        view.backgroundColor = .white
        view.font = UIFont.systemFont(ofSize: 32, weight: .regular)
        view.textColor = .black
        
        return view
    }()
    
    private lazy var scrollView1: UIScrollView = {
        let view = UIScrollView()
        
        view.frame = CGRect.init(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        
        view.contentSize = CGSize.init(width: self.view.frame.width, height: self.stackView1.frame.height + 50)
        
        return view
    }()
    
    private lazy var scrollView2: UIScrollView = {
        let view = UIScrollView()
        
        view.frame = CGRect.init(x: 0, y: 0, width: self.view.frame.width, height: 152 + 16)
        
        view.contentSize = CGSize.init(width: self.stackView2.frame.width + 20, height: 152 + 16)
        
        view.bounces = false
        view.contentInset = UIEdgeInsets.init(
            top: 8,
            left: 10,
            bottom: 8,
            right: 10
        )
        
        return view
    }()
    
    private lazy var stackView2: UIStackView = {
        let view = UIStackView()
        
        view.axis = .horizontal
        view.distribution = .fillEqually
        view.spacing = 8
        
        view.frame = CGRect.init(
            x: 0,
            y: 0,
            width: 800,
            height: 152)
        
        view.backgroundColor = .lightGray
        
        return view
    }()
    
    // MARK: - Parent delegates

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
//        self.view.addSubview(self.view1)
//        self.view.addSubview(self.btn1)
//        self.view.addSubview(self.image1)
//        self.view.addSubview(self.slider1)
        
        self.view.addSubview(self.scrollView1)
        
        self.scrollView1.addSubview(self.stackView1)

        self.stackView1.addArrangedSubview(self.viewChild1)
        self.stackView1.addArrangedSubview(self.viewChild2)
        self.stackView1.addArrangedSubview(self.viewChild3)
        self.stackView1.addArrangedSubview(self.viewChild4)
        self.stackView1.addArrangedSubview(self.viewChild5)
        
        self.stackView1.addArrangedSubview(self.scrollView2)
        self.scrollView2.addSubview(self.stackView2)
        
        for _ in 0...8 {
            let childView = self.getRectangleView(152)
            self.stackView2.addArrangedSubview(childView)
        }
    }
    
    func getRectangleView(_ size: Int) -> UIView {
        let view = UIView()
        
        view.backgroundColor = .systemBlue
        
        view.frame = CGRect.init(x: 0, y: 0, width: size, height: size)
        
        return view
    }
    
    // MARK: - Click handlers
    
    @objc func onClick() {
        print("on clicked")
        self.btn1.isEnabled.toggle()
    }
    
    @objc func onBtnClick() {
        print("on btn clicked")
    }
    
    @objc func onSliderChange(_ slider: UISlider) {
        print("on slider changed: \(slider.value)")
        
        self.view1.backgroundColor = UIColor.init(red: CGFloat(slider.value), green: 0.5, blue: 0.5, alpha: 1.0)
    }
}
