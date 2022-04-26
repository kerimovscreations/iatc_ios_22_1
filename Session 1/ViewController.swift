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
    
    private var selectedDate: Date? = nil {
        didSet {
            self.updateDateText()
        }
    }
    
    private let datePicker: UIDatePicker = {
        let picker = UIDatePicker.init()
        
        picker.datePickerMode = .dateAndTime
        picker.preferredDatePickerStyle = .compact
        
        picker.addTarget(self, action: #selector(onDateChanged(_:)), for: .valueChanged)
        
        return picker
    }()
    
    private let segments = ["Segment 1", "Segment 2", "Segment 3"]
    
    // MARK: - UI Components
    
    private lazy var segmentedControl: UISegmentedControl = {
        let sgcnt = UISegmentedControl.init(items: self.segments)
        
        self.view.addSubview(sgcnt)
        
        sgcnt.addTarget(self, action: #selector(onSegmentChanged(_:)), for: .valueChanged)
        
        return sgcnt
    }()
    
    private lazy var pickDateBtn: UIButton = {
        let btn = UIButton()
        
        self.view.addSubview(btn)
                
        btn.setTitle("Select date", for: .normal)
        btn.setTitleColor(UIColor.blue, for: .normal)
        
        btn.addTarget(self, action: #selector(onPickDate), for: .touchUpInside)
        
        return btn
    }()
    
    private lazy var selectedDateLabel: UILabel = {
        let label = UILabel()
        
        self.view.addSubview(label)
        
        return label
    }()
    
//    private lazy var datePickerInput: UITextField = {
//        let field = UITextField()
//
//        self.view.addSubview(field)
//
//        field.placeholder = "Date picker input"
//
//        return field
//    }()
    
    private lazy var stepperView: UIStepper = {
        let view = UIStepper()
        
        self.view.addSubview(view)
        
        view.stepValue = 0.1
        
        view.maximumValue = 5.0
        view.minimumValue = 0.1
        view.value = 0.1
        view.isContinuous = true
        
        view.addTarget(self, action: #selector(onStepperChanged(_:)), for: .valueChanged)
        
        return view
    }()
    
    private lazy var containerScrollView: UIScrollView = {
        let view = UIScrollView()

        self.view.addSubview(view)
        
        view.isPagingEnabled = true
        
        view.delegate = self

        return view
    }()
    
    private lazy var pageControl: UIPageControl = {
        let view = UIPageControl()
        
        self.view.addSubview(view)
        
        view.pageIndicatorTintColor = .lightGray
        view.currentPageIndicatorTintColor = .systemBlue
        
        view.addTarget(self, action: #selector(onPageControlChanged(_:)), for: .valueChanged)
        
        return view
    }()
    
//    private lazy var containerView: UIView = {
//        let view = UIView()
//
//        self.view.addSubview(view)
//
//        return view
//    }()
//
//    private lazy var segment1View: UIView = {
//        let view = UIView()
//
//        view.backgroundColor = .systemBlue
//
//        return view
//    }()
//
//    private lazy var segment2View: UIView = {
//        let view = UIView()
//
//        view.backgroundColor = .systemRed
//
//        return view
//    }()
//
//    private lazy var segment3View: UIView = {
//        let view = UIView()
//
//        view.backgroundColor = .systemGray
//
//        return view
//    }()
    
    // MARK: - Parent delegates

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        self.pickDateBtn.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(16)
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left).offset(16)
        }
        
        self.selectedDateLabel.snp.makeConstraints { make in
            make.top.equalTo(self.pickDateBtn.snp.bottom).offset(16)
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left).offset(16)
            make.right.equalTo(self.view.safeAreaLayoutGuide.snp.right).offset(-16)
        }
        
//        self.datePickerInput.snp.makeConstraints { make in
//            make.top.equalTo(self.selectedDateLabel.snp.bottom).offset(16)
//            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left).offset(16)
//            make.right.equalTo(self.view.safeAreaLayoutGuide.snp.right).offset(-16)
//        }
//
//        self.datePickerInput.inputView = datePicker
        
        self.stepperView.snp.makeConstraints { make in
            make.top.equalTo(self.selectedDateLabel.snp.bottom).offset(16)
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left).offset(16)
        }
        
        self.segmentedControl.snp.makeConstraints { make in
            make.top.equalTo(self.stepperView.snp.bottom).offset(16)
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left).offset(16)
            make.right.equalTo(self.view.safeAreaLayoutGuide.snp.right).offset(-16)
        }
        
        self.containerScrollView.snp.makeConstraints { make in
            make.top.equalTo(self.segmentedControl.snp.bottom).offset(16)
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left)
            make.right.equalTo(self.view.safeAreaLayoutGuide.snp.right)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-36)
        }
        
        self.pageControl.snp.makeConstraints { make in
            make.top.equalTo(self.containerScrollView.snp.bottom).offset(8)
            make.centerX.equalTo(self.view.snp.centerX)
        }
        
        
//        self.containerView.snp.makeConstraints { make in
//            make.top.equalTo(self.segmentedControl.snp.bottom).offset(16)
//            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left)
//            make.right.equalTo(self.view.safeAreaLayoutGuide.snp.right)
//            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
//        }
    }
    
    // MARK: - Functions
    
    private func updateDateText() {
        guard let date = self.selectedDate else {
            self.selectedDateLabel.text = "Not selected"
            return
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
        
        self.selectedDateLabel.text = dateFormatter.string(from: date)
    }
    
    @objc func onPickDate() {
//        self.selectedDate = Date()
//        self.showDatePicker()
        
        self.pageControl.numberOfPages = self.segments.count
        self.pageControl.currentPage = 0
        
        self.containerScrollView.subviews.forEach { subView in
            subView.removeFromSuperview()
        }
        
        for i in self.segments.indices {
            let segmentView = UIView()
            
            self.containerScrollView.addSubview(segmentView)
            
            segmentView.frame = CGRect.init(
                x: CGFloat(i) * self.containerScrollView.frame.width,
                y: 0,
                width: self.containerScrollView.frame.width,
                height: self.containerScrollView.frame.height
            )
                        
            segmentView.backgroundColor = [.red, .blue, .yellow, .gray, .green][i]
        }
        
        self.containerScrollView.contentSize = CGSize.init(
            width: CGFloat(self.segments.count) * self.containerScrollView.frame.width,
            height:  self.containerScrollView.frame.height)
    }
    
    @objc func onDateChanged(_ sender: UIDatePicker) {
        self.selectedDate = sender.date
    }
    
    @objc func onStepperChanged(_ sender: UIStepper) {
        self.selectedDateLabel.text = String.init(format: "%.1f", sender.value)
    }
    
    @objc func onPageControlChanged(_ sender: UIPageControl) {
        self.containerScrollView.setContentOffset(CGPoint.init(x: CGFloat(sender.currentPage) * self.containerScrollView.frame.width, y: 0), animated: true)
    }
    
    @objc func onSegmentChanged(_ sender: UISegmentedControl) {
        print(sender.selectedSegmentIndex)
//        switch sender.selectedSegmentIndex {
//        case 0:
//            self.fillContainer(with: self.segment1View)
//        case 1:
//            self.fillContainer(with: self.segment2View)
//        case 2:
//            self.fillContainer(with: self.segment3View)
//        default:
//            break
//        }
    }
    
//    private func fillContainer(with view: UIView) {
//        self.containerView.subviews.forEach { subView in
//            subView.removeFromSuperview()
//        }
//
//        self.containerView.addSubview(view)
//
//        view.snp.makeConstraints { make in
//            make.top.left.right.bottom.equalToSuperview()
//        }
//    }
    
    private func showDatePicker() {
        self.view.addSubview(self.datePicker)
        self.datePicker.snp.makeConstraints { make in
            make.centerY.equalTo(self.pickDateBtn.snp.centerY)
            make.left.equalTo(self.pickDateBtn.snp.right).offset(16)
            make.right.equalTo(self.view.safeAreaLayoutGuide.snp.right).offset(-16)
        }
    }
    
    private func hideDatePicker() {
        self.datePicker.removeFromSuperview()
    }
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x / scrollView.frame.width)
        self.pageControl.currentPage = index
    }
}
