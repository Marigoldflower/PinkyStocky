//
//  TopNewsViewCell.swift
//  MyStockApp
//
//  Created by 황홍필 on 2023/03/18.
//

import UIKit


final class WorldWideTopNewsCell: UICollectionViewCell {
    
    static let identifier = "WorldWideTopNewsCell"
    
    // MARK: - 컬렉션 뷰 셀 객체
    
    
    let topNewsImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    
    
    let topNewsTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 19, weight: .heavy)
        label.numberOfLines = 2
        return label
    }()
    
    
    let topNewsDescription: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .light)
        label.numberOfLines = 2
        return label
    }()
    
    
    
    
   
    
    
    
    
    // MARK: - 스택 뷰
    
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [topNewsTitle, topNewsDescription])
        stack.axis = .vertical
        stack.spacing = 5
        return stack
    }()
    
    
    // 컬렉션 뷰 셀에서 viewDidLoad 역할을 하는 생성자
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(topNewsImageView)
        contentView.addSubview(stackView)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    private func setupConstraints() {
        
        
        topNewsImageView.translatesAutoresizingMaskIntoConstraints = false
        
        topNewsImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0).isActive = true
        topNewsImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive = true
        topNewsImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        topNewsImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -95).isActive = true
        

        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.leadingAnchor.constraint(equalTo: topNewsImageView.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        stackView.trailingAnchor.constraint(equalTo: topNewsImageView.safeAreaLayoutGuide.trailingAnchor, constant: -15).isActive = true
        
        stackView.topAnchor.constraint(equalTo: topNewsImageView.bottomAnchor, constant: 12).isActive = true
        
        
        
    }
    
}
