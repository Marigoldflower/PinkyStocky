//
//  HomeControllerHeaderView.swift
//  MyStockApp
//
//  Created by 황홍필 on 2023/03/15.
//

import UIKit

class HomeControllerHeaderView: UITableViewHeaderFooterView {

    static let identifier = "HomeControllerHeaderView"
    
    
    let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = .autumnPink
        return view
    }()
    
    
    

 
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        
        // ⭐️ UITableViewHeaderFooterView 내에서는 view가 아니라 contentView라고 적는다 ⭐️
        self.addSubview(headerView)
        
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
        
        
        

    }
}
