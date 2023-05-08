//
//  StockHeaderView.swift
//  MyStockApp
//
//  Created by 황홍필 on 2023/02/23.
//

import UIKit



class CompanyNewsHeaderView: UITableViewHeaderFooterView {

    
    let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = .autumnPink
        return view
    }()
    
    
    let headerText: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 14)
        return label
    }()
    

    let goBackButton: UIButton = {
        let button = UIButton(type: .close)
        button.sizeToFit()
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        return button
    }()
    

    
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .autumnPink
        
        // ⭐️ UITableViewHeaderFooterView 내에서는 view가 아니라 contentView라고 적는다 ⭐️
        contentView.addSubview(headerView)
        contentView.addSubview(goBackButton)
        contentView.addSubview(headerText)
        
        setConstraints()
        
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

    
    
    func setConstraints() {
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        headerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        headerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        headerView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        headerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        
        headerText.translatesAutoresizingMaskIntoConstraints = false
        
        headerText.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        headerText.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        headerText.widthAnchor.constraint(equalToConstant: 250).isActive = true
        
        
        
        goBackButton.translatesAutoresizingMaskIntoConstraints = false
        
        goBackButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15).isActive = true
        goBackButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        goBackButton.widthAnchor.constraint(equalToConstant: 15).isActive = true
        goBackButton.heightAnchor.constraint(equalToConstant: 15).isActive = true
    }
        
        
        
   
        
        
        
        
        
    
    
    
    
    
    
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
