//
//  RecommendationView.swift
//  MyStockApp
//
//  Created by 황홍필 on 2023/04/06.
//

import UIKit

protocol FinancialReloadButtonDelegate: AnyObject {
    func reloadButtonTapped(_ recommendationView: RecommendationView)
}


final class RecommendationView: UIView {

    
    var delegate: FinancialReloadButtonDelegate?
    
    
    let recommendation: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 19)
        label.textColor = .headerPink
        label.text = "Recommended Stock ☺️"
        return label
    }()
    
    
    let reloadButton: UIButton = {
        let button = UIButton()
        button.setTitle("Reload", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 13, weight: .regular)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .autumnPink
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 4
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .pinkBeige
        self.addSubview(recommendation)
        self.addSubview(reloadButton)
        setupLayout()
        reloadButton.addTarget(self, action: #selector(reloadButtonTapped), for: .touchUpInside)
    }
    
    
    @objc private func reloadButtonTapped() {
        delegate?.reloadButtonTapped(self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupLayout() {
        recommendation.translatesAutoresizingMaskIntoConstraints = false
        
        recommendation.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        recommendation.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        
        reloadButton.translatesAutoresizingMaskIntoConstraints = false
        
        reloadButton.leadingAnchor.constraint(equalTo: recommendation.trailingAnchor, constant: 30).isActive = true
        reloadButton.centerYAnchor.constraint(equalTo: recommendation.centerYAnchor).isActive = true
        reloadButton.widthAnchor.constraint(equalToConstant: 55).isActive = true
        reloadButton.heightAnchor.constraint(equalToConstant: 17).isActive = true
    }
}
