//
//  DataCollectionView.swift
//  MyStockApp
//
//  Created by 황홍필 on 2023/03/06.
//

import UIKit

class DataCollectionView: UIView {
    
    
    
    let emptyLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    
    
    // MARK: - 레이블 객체
    
    var the10DayAverageTradingVolume: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 14)
        return label
    }()
    
    
    
    var the52WeekLow: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 14)

        return label
    }()
    
    
    
    var the52WeekHigh: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 14)

        return label
    }()
    
    
    var the52WeekPriceReturnDaily: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 14)

        return label
    }()
    
    
    var beta: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 14)

        return label
    }()
    
    
    
    // MARK: - 스택 뷰
    
    lazy var firstStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [the52WeekHigh, the52WeekLow, the52WeekPriceReturnDaily])
        stack.axis = .vertical
        stack.spacing = 5
        stack.distribution = .fill
        return stack
    }()
    
    
    lazy var secondStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [the10DayAverageTradingVolume, beta])
        stack.axis = .vertical
        stack.spacing = 5
        stack.distribution = .fill
        return stack
    }()
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .pinkBeige
        addSubviews(firstStackView, secondStackView)
        addSubview(emptyLabel)
        setupConstraints()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError()
    }

    
    func setupConstraints() {
        
        
        firstStackView.translatesAutoresizingMaskIntoConstraints = false
        
        firstStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15).isActive = true
        
        firstStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        
        
        
        secondStackView.translatesAutoresizingMaskIntoConstraints = false
        
        secondStackView.leadingAnchor.constraint(equalTo: firstStackView.leadingAnchor, constant: 230).isActive = true
        secondStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        
        
        emptyLabel.translatesAutoresizingMaskIntoConstraints = false
        
        emptyLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        emptyLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        
    }
    
}
