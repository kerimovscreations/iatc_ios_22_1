//
//  ViewController.swift
//  Session 1
//
//  Created by Karim Karimov on 05.04.22.
//

import UIKit
import SnapKit

struct BasketItem {
    let product: Product
}

struct Product {
    let title: String
}

struct Category: Hashable {
    let title: String
    
    static func == (lhs: Category, rhs: Category) -> Bool {
        return lhs.title == rhs.title
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
    }
}

class ViewController: UIViewController {
    
    // MARK: - Variables
    
    private let basketItems: [BasketItem] = [
        BasketItem(product: Product(title: "Salad")),
        BasketItem(product: Product(title: "Lenit soup")),
        BasketItem(product: Product(title: "Basdirma")),
        BasketItem(product: Product(title: "Salad")),
        BasketItem(product: Product(title: "Lenit soup")),
        BasketItem(product: Product(title: "Basdirma")),
        BasketItem(product: Product(title: "Salad")),
        BasketItem(product: Product(title: "Lenit soup")),
        BasketItem(product: Product(title: "Basdirma")),
        BasketItem(product: Product(title: "Lenit soup")),
        BasketItem(product: Product(title: "Basdirma")),
        BasketItem(product: Product(title: "Salad")),
        BasketItem(product: Product(title: "Lenit soup")),
        BasketItem(product: Product(title: "Basdirma"))
    ]
    
    private let basketItemsBottom: [BasketItem] = [
        BasketItem(product: Product(title: "Salad2")),
        BasketItem(product: Product(title: "Lenit soup2")),
        BasketItem(product: Product(title: "Basdirma2")),
        BasketItem(product: Product(title: "Salad2")),
        BasketItem(product: Product(title: "Lenit soup2")),
        BasketItem(product: Product(title: "Basdirma2")),
        BasketItem(product: Product(title: "Salad2")),
        BasketItem(product: Product(title: "Lenit soup2")),
        BasketItem(product: Product(title: "Basdirma2")),
        BasketItem(product: Product(title: "Lenit soup2")),
        BasketItem(product: Product(title: "Basdirma2")),
        BasketItem(product: Product(title: "Salad2")),
    ]
    
    private let categories: [Category] = [
        Category(title: "All dishes"),
        Category(title: "Soups"),
        Category(title: "Starters"),
        Category(title: "Main dishes"),
        Category(title: "Desserts"),
        Category(title: "Beverages"),
    ]
    
    private var selectedCategory: Category? = nil {
        didSet {
            self.updateCategoryView()
        }
    }
    
    private var categoryViews: [CategoryChipView] = []
    
    // MARK: - UI Components
    
    let basketItemCell = "basket_item_cell"
    
//    private lazy var tableView: UITableView = {
//        let tableView = UITableView()
//
//        self.view.addSubview(tableView)
//
//        tableView.dataSource = self
//        tableView.delegate = self
//
//        tableView.register(BasketItemTableViewCell.self, forCellReuseIdentifier: self.basketItemCell)
//
//        tableView.separatorStyle = .none
//
//        return tableView
//    }()
    
    private lazy var categoryScrollView: UIScrollView = {
        let view = UIScrollView()
        
        self.view.addSubview(view)
        
        return view
    }()
    
    private lazy var categoryStackView: UIStackView = {
        let view = UIStackView()
        
        self.categoryScrollView.addSubview(view)
        
        view.axis = .horizontal
        view.distribution = .equalSpacing
        view.spacing = 16
        
        return view
    }()
    
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        
        flowLayout.scrollDirection = .vertical
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)

        self.view.addSubview(view)
        
        view.register(BasketItemCollectionViewCell.self, forCellWithReuseIdentifier: self.basketItemCell)
        
        view.dataSource = self
        view.delegate = self
        
        view.bounces = true
        view.alwaysBounceVertical = true
        
        view.contentInset.left = 8
        view.contentInset.right = 8
        view.contentInset.top = 8
        
        return view
    }()
    
    private lazy var collectionViewBottom: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        
        flowLayout.scrollDirection = .vertical
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)

        self.view.addSubview(view)
        
        view.register(BasketItemBottomCollectionViewCell.self, forCellWithReuseIdentifier: self.basketItemCell)
        
        view.dataSource = self
        view.delegate = self
        
        view.bounces = true
        view.alwaysBounceVertical = true
        
        view.contentInset.left = 8
        view.contentInset.right = 8
        view.contentInset.top = 8
        
        return view
    }()
    
    // MARK: - Parent delegates

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
//        self.tableView.snp.makeConstraints { make in
//            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left)
//            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
//            make.right.equalTo(self.view.safeAreaLayoutGuide.snp.right)
//            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
//        }
        
        self.categoryScrollView.snp.makeConstraints { make in
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.right.equalTo(self.view.safeAreaLayoutGuide.snp.right)
            make.height.equalTo(56)
        }
        
        self.categoryStackView.snp.makeConstraints { make in
            make.left.equalTo(self.categoryScrollView.contentLayoutGuide.snp.left).offset(16)
            make.right.equalTo(self.categoryScrollView.contentLayoutGuide.snp.right).offset(-16)
            make.top.equalTo(self.categoryScrollView.contentLayoutGuide.snp.top).offset(8)
            make.bottom.equalTo(self.categoryScrollView.contentLayoutGuide.snp.bottom).offset(-8)
            make.height.equalTo(40)
            make.centerY.equalTo(self.categoryScrollView.snp.centerY)
        }
                
        self.collectionView.snp.makeConstraints { make in
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left)
            make.top.equalTo(self.categoryScrollView.snp.bottom).offset(16)
            make.right.equalTo(self.view.safeAreaLayoutGuide.snp.right)
            make.bottom.equalTo(self.view.snp.centerY)
        }
        
        self.collectionViewBottom.snp.makeConstraints { make in
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left)
            make.top.equalTo(self.view.snp.centerY)
            make.right.equalTo(self.view.safeAreaLayoutGuide.snp.right)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
        
        for i in self.categories.indices {
            let category = self.categories[i]
            let view = CategoryChipView()
            view.setTitle(category)
            view.tag = i
            
            let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectCategory(_:)))
            view.addGestureRecognizer(gestureRecognizer)
            
            self.categoryViews.append(view)
        }
        
        self.categoryViews.forEach { view in
            self.categoryStackView.addArrangedSubview(view)
        }
    }
    
    @objc func selectCategory(_ recognizer: UIGestureRecognizer) {
        guard let index = recognizer.view?.tag else { return }
        
        let category = self.categories[index]
        if self.selectedCategory == category {
            
        } else {
            self.selectedCategory = category
        }
    }
    
    private func updateCategoryView() {
        self.categoryViews.forEach { view in
            view.setSelected(self.selectedCategory == view.categoryItem)
        }
    }
}

extension ViewController:
    UICollectionViewDataSource,
    UICollectionViewDelegate,
    UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionView {
            return self.basketItems.count
        } else {
            return self.basketItemsBottom.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.basketItemCell, for: indexPath) as! BasketItemCollectionViewCell
            
            let basketItem = self.basketItems[indexPath.row]
            
            cell.setTitle(basketItem.product.title)
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.basketItemCell, for: indexPath) as! BasketItemBottomCollectionViewCell
            
            let basketItem = self.basketItems[indexPath.row]
            
            cell.setTitle(basketItem.product.title)
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.collectionView {
            return CGSize(width: self.view.frame.width - 16, height: 50)
        } else {
            return CGSize(width: (self.view.frame.width - 24) / 2, height: 50)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

//extension ViewController: UITableViewDataSource, UITableViewDelegate {
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.basketItems.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: basketItemCell) as! BasketItemTableViewCell
//
//        let basketItem = self.basketItems[indexPath.row]
//
//        cell.setTitle(basketItem.product.title)
//
//        return cell
//    }
//
//}

//class BasketItemTableViewCell: UITableViewCell {
//
//    // MARK: - UI Components
//
//    private lazy var titleLabel: UILabel = {
//        let label = UILabel()
//
//        label.textColor = .darkText
//        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
//
//        label.numberOfLines = 0
//
//        return label
//    }()
//
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//
//        setupUI()
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    private func setupUI() {
//
//        self.contentView.addSubview(self.titleLabel)
//
//        self.titleLabel.snp.makeConstraints { make in
//            make.top.equalTo(self.contentView.snp.top).offset(12)
//            make.bottom.equalTo(self.contentView.snp.bottom).offset(-12)
//            make.left.equalTo(self.contentView.snp.left).offset(16)
//            make.right.equalTo(self.contentView.snp.right).offset(-16)
//        }
//    }
//
//    func setTitle(_ title: String) {
//        self.titleLabel.text = title
//    }
//}

class BasketItemCollectionViewCell: UICollectionViewCell {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()

        label.textColor = .darkText
        
        guard let customFont = UIFont(name: "Mulish-SemiBold", size: 24) else {
            fatalError("""
                Failed to load the "Mulish-SemiBold" font.
                Make sure the font file is included in the project and the font name is spelled correctly.
                """
            )
        }
        label.font = UIFontMetrics.default.scaledFont(for: customFont)
        label.adjustsFontForContentSizeCategory = true

        label.numberOfLines = 0

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
        self.contentView.addSubview(titleLabel)
        
        self.titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self.contentView.snp.centerY)
            make.left.equalTo(self.contentView.snp.left).offset(16)
            make.right.equalTo(self.contentView.snp.right).offset(-16)
        }
    }
    
    func setTitle(_ title: String) {
        self.titleLabel.text = title
    }
}

class BasketItemBottomCollectionViewCell: UICollectionViewCell {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()

        label.textColor = .darkText
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)

        label.numberOfLines = 0

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
        self.contentView.addSubview(titleLabel)
        
        self.contentView.backgroundColor = .systemBlue
        
        self.titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self.contentView.snp.centerY)
            make.left.equalTo(self.contentView.snp.left).offset(16)
            make.right.equalTo(self.contentView.snp.right).offset(-16)
        }
    }
    
    func setTitle(_ title: String) {
        self.titleLabel.text = title
    }
}

class CategoryChipView: UIView {
    
    var categoryItem: Category? = nil
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        
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
        self.addSubview(self.titleLabel)
        
        self.titleLabel.snp.makeConstraints { make in
            make.left.equalTo(self.snp.left).offset(8)
            make.right.equalTo(self.snp.right).offset(-8)
            make.centerY.equalTo(self.snp.centerY)
        }
        
        self.layer.cornerRadius = 16
        self.clipsToBounds = true
        
        self.setSelected(false)
    }
    
    func setTitle(_ category: Category) {
        self.categoryItem = category
        self.titleLabel.text = category.title
    }
    
    func setSelected(_ state: Bool) {
        if state {
            self.backgroundColor = hexStringToUIColor(hex: "FFB01D")
            self.titleLabel.textColor = .white
        } else {
            self.backgroundColor = .clear
            self.titleLabel.textColor = hexStringToUIColor(hex: "FFB01D")
        }
        
    }
}

func hexStringToUIColor (hex:String) -> UIColor {
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

    if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
    }

    if ((cString.count) != 6) {
        return UIColor.gray
    }

    var rgbValue:UInt64 = 0
    Scanner(string: cString).scanHexInt64(&rgbValue)

    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}
