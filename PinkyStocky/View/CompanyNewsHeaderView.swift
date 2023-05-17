//
//  StockHeaderView.swift
//  MyStockApp
//
//  Created by 황홍필 on 2023/02/23.
//

import UIKit


protocol AddStockListButtonDelegate: AnyObject {
    func addStockListButtonTapped(_ header: CompanyNewsHeaderView)
}

final class CompanyNewsHeaderView: UITableViewHeaderFooterView {


    weak var delegate: AddStockListButtonDelegate?
    

    let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = .autumnPink
        return view
    }()
    
    
    let headerText: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 25)
        return label
    }()
    

    let addToMyStockList: UIButton = {
        let button = UIButton()
        button.backgroundColor = .tintPink
        button.setTitleColor(.white, for: .normal)
        let attributedTitle = NSAttributedString(string: "+ StockList", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14), NSAttributedString.Key.foregroundColor : UIColor.white])
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        return button
    }()
    

    
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .autumnPink
        
        // ⭐️ UITableViewHeaderFooterView 내에서는 view가 아니라 contentView라고 적는다 ⭐️
        self.addSubview(headerView)
        self.addSubview(addToMyStockList)
        self.addSubview(headerText)
        
        setConstraints()
        
        addToMyStockList.addTarget(self, action: #selector(addToMyStockListButtonTouched), for: .touchUpInside)
        
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    

    
    
    private func setConstraints() {
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        headerView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        headerView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        headerView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        headerView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        
        headerText.translatesAutoresizingMaskIntoConstraints = false
        
        headerText.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        headerText.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        
        
        
        addToMyStockList.translatesAutoresizingMaskIntoConstraints = false
        
        addToMyStockList.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15).isActive = true
        addToMyStockList.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        addToMyStockList.widthAnchor.constraint(equalToConstant: 100).isActive = true
        addToMyStockList.heightAnchor.constraint(equalToConstant: 27).isActive = true
    }
        
        
    @objc private func addToMyStockListButtonTouched() {
        delegate?.addStockListButtonTapped(self)
    }

}
