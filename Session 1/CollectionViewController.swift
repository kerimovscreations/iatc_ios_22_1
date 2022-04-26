//
//  CollectionViewController.swift
//  Session 1
//
//  Created by Karim Karimov on 26.04.22.
//

import Foundation
import UIKit

class CollectionViewController: UIViewController {
    
    // MARK: - Variables
    
    private let ingredients = ["Egg", "Bacon", "Tomato", "Potato", "Egg", "Bacon", "Tomato", "Potato", "Egg", "Bacon", "Tomato", "Potato"]
    
    // MARK: - UI Components
    
    private lazy var containerScrollView: UIScrollView = {
        let view = UIScrollView()
        
        self.view.addSubview(view)
        
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        
        self.containerScrollView.addSubview(view)
        
        view.axis = .vertical
        view.distribution = .equalSpacing
        view.spacing = 16
        
        return view
    }()
    
    private lazy var ingredientCollectionView: UICollectionView = {
        let flow = UICollectionViewFlowLayout.init()
        flow.scrollDirection = .horizontal
        
        let view = UICollectionView.init(frame: .zero, collectionViewLayout: flow)
                
        view.dataSource = self
        view.delegate = self
        
        view.register(IngredientCollectionViewCell.self, forCellWithReuseIdentifier: "ingredient_cell")
        
        view.contentInset.left = 24
        view.contentInset.left = 24
        flow.minimumInteritemSpacing = 16
        
        return view
    }()
    
    // MARK: - Parent delegates
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        self.containerScrollView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left)
            make.right.equalTo(self.view.safeAreaLayoutGuide.snp.right)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
        
        self.stackView.snp.makeConstraints { make in
            make.top.equalTo(self.containerScrollView.contentLayoutGuide.snp.top)
            make.left.equalTo(self.containerScrollView.contentLayoutGuide.snp.left)
            make.right.equalTo(self.containerScrollView.contentLayoutGuide.snp.right)
            make.bottom.equalTo(self.containerScrollView.contentLayoutGuide.snp.bottom)
            make.centerX.equalTo(self.containerScrollView.snp.centerX)
        }
        
        self.stackView.addArrangedSubview(self.ingredientCollectionView)

        self.ingredientCollectionView.snp.makeConstraints { make in
            make.height.equalTo(74)
        }
    }
}

extension CollectionViewController:
    UICollectionViewDataSource,
    UICollectionViewDelegateFlowLayout,
        UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.ingredients.count
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ingredient_cell", for: indexPath) as! IngredientCollectionViewCell
        
        cell.setupTitle(self.ingredients[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: 92, height: 74)
    }

}

class IngredientCollectionViewCell: UICollectionViewCell {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        self.contentView.addSubview(label)
        label.font = .systemFont(ofSize: 14)
        label.textColor = .darkText
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        titleLabel.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(8)
            make.right.bottom.equalToSuperview().offset(-8)
        }
    }
    
    func setupTitle(_ title: String) {
        self.titleLabel.text = title
    }
    
}
