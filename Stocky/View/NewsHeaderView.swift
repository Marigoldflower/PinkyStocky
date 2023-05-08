//
//  NewsHeaderView.swift
//  MyStockApp
//
//  Created by 황홍필 on 2023/03/18.
//

import UIKit

class NewsHeaderView: UITableViewHeaderFooterView {

    static let identifier = "NewsHeaderView"
    
    
    let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = .autumnPink
        return view
    }()
    
    
    let headerText: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 18)
        label.text = "LATEST FINANCIAL NEWS"
        return label
    }()
    
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        
        // ⭐️ UITableViewHeaderFooterView 내에서는 view가 아니라 contentView라고 적는다 ⭐️
        self.addSubview(headerView)
        self.addSubview(headerText)
        
        setConstraints()
        
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    

    
    
    func setConstraints() {
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        headerView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        headerView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        headerView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        headerView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        
        
        headerText.translatesAutoresizingMaskIntoConstraints = false
        
        headerText.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        headerText.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        

    }
}
