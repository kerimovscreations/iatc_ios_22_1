//
//  ToolbarView.swift
//  Session 1
//
//  Created by Karim Karimov on 19.04.22.
//

import UIKit
import SnapKit

class ToolbarView : UIView {
    
    private lazy var label : UILabel = {
        let label = UILabel()
        self.addSubview(label)
        label.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        label.textColor = .black

        return label
    }()
    
    private lazy var gridImageView: UIImageView = {
       let imgView = UIImageView()
        self.addSubview(imgView)
        imgView.backgroundColor = .systemGreen
        return imgView
    }()
    
    private lazy var listImageView: UIImageView = {
       let imgView = UIImageView()
        self.addSubview(imgView)
        imgView.backgroundColor = .lightGray
        return imgView
    }()
    
    
    
    //initWithFrame to init view from code
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    //initWithCode to init view from xib or storyboard
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    //common func to init our view
    private func setupView() {
        self.backgroundColor = .white
        self.label.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.equalTo(self.gridImageView.snp.left).offset(-16)
            make.centerY.equalToSuperview()
            
        }
        self.label.text = "Recently Booked"
        
        self.listImageView.snp.makeConstraints { make in
            make.width.height.equalTo(36)
            make.right.equalToSuperview().offset(-16)
            make.centerY.equalTo(self.label.snp.centerY)
        }
        
        self.gridImageView.snp.makeConstraints { make in
            make.right.equalTo(self.listImageView.snp.left).offset(-16)
            make.centerY.equalTo(self.label.snp.centerY)
            make.height.width.equalTo(36)
        }
        
    }
    
}
