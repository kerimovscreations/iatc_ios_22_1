//
//  ToolbarView.swift
//  Session 1
//
//  Created by Karim Karimov on 19.04.22.
//

import UIKit
import SnapKit

class HouseListView : UIView {
    
    private lazy var roomImageView: UIImageView = {
       let imgView = UIImageView()
        self.addSubview(imgView)
        imgView.backgroundColor = .systemGreen
        imgView.layer.cornerRadius = 16
        imgView.clipsToBounds = true
        
        return imgView
    }()
    
    private lazy var titleLabel: UILabel = {
        let lbl = UILabel()
        self.addSubview(lbl)
        lbl.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        lbl.textColor = .darkText
        
        return lbl
    }()
    
    
    private lazy var priceLabel: UILabel = {
        let lbl = UILabel()
        self.addSubview(lbl)
        lbl.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        lbl.textColor = .systemGreen
        
        return lbl
    }()
    
    
    private lazy var descriptionLabel: UILabel = {
        let lbl = UILabel()
        self.addSubview(lbl)
        lbl.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        lbl.textColor = .lightGray
        
        return lbl
    }()
    
    private lazy var ratingLabel: UILabel = {
        let lbl = UILabel()
        self.addSubview(lbl)
        lbl.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        lbl.textColor = .systemGreen
        
        return lbl
    }()
    
    private lazy var ratingCountLabel: UILabel = {
        let lbl = UILabel()
        self.addSubview(lbl)
        lbl.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        lbl.textColor = .lightGray
        
        return lbl
    }()
    
    private lazy var ratingImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "ic_star")
        view.contentMode = .scaleAspectFit
        
        self.addSubview(view)
        return view
        
        
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
        
        self.layer.cornerRadius = 24
        self.clipsToBounds = true
       
        roomImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(8)
            make.top.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().offset(-8)
            make.height.width.equalTo(96)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(roomImageView.snp.right).offset(8)
            make.top.equalToSuperview().offset(8)
            make.right.equalTo(priceLabel.snp.left).offset(-8)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.right.equalToSuperview().offset(-8)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.left.equalTo(roomImageView.snp.right).offset(8)
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.right.equalToSuperview().offset(-8)
        }
        
        titleLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)

        priceLabel.setContentHuggingPriority(.required, for: .horizontal)
        priceLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
 
        ratingImageView.snp.makeConstraints { make in
            make.left.equalTo(roomImageView.snp.right).offset(8)
            
            make.bottom.equalTo(roomImageView.snp.bottom)
            make.width.height.equalTo(16)
        }
        
        ratingLabel.snp.makeConstraints { make in
            make.left.equalTo(ratingImageView.snp.right).offset(8)
            make.bottom.equalTo(ratingImageView.snp.bottom)
        }
        
        ratingCountLabel.snp.makeConstraints { make in
            make.bottom.equalTo(ratingImageView.snp.bottom)
            make.left.equalTo(ratingLabel.snp.right).offset(8)
            make.right.lessThanOrEqualToSuperview().offset(-8)
        }
        
    }
    func setup(house: House) {
        self.titleLabel.text = house.title
        self.priceLabel.text = house.price
        self.descriptionLabel.text = house.description
        self.ratingLabel.text = "\(house.rating)"
        self.ratingCountLabel.text = "(\(house.ratingCount) reviews)"
    }
}

