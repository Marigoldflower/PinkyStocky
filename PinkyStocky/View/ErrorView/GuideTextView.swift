//
//  GuideTextView.swift
//  MyStockApp
//
//  Created by 황홍필 on 2023/03/22.
//

import UIKit

class GuideTextView: UIView {

    
    let guideLabel: UILabel = {
        let label = UILabel()
        let stringOne = "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\nAssign stocks to MyStockList...☺️"
        let stringTwo = "MyStockList"
        
        let range = (stringOne as NSString).range(of: stringTwo)
        
        
        let attributedText = NSMutableAttributedString.init(string: stringOne)
        attributedText.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.headerPink, range: range)
        label.attributedText = attributedText
        
        label.font = .boldSystemFont(ofSize: 14)
        label.numberOfLines = 0
        
        
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(guideLabel)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        setConstraints()
        super.updateConstraints()
    }
    
    
    func setConstraints() {
        
        guideLabel.translatesAutoresizingMaskIntoConstraints = false

        guideLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        guideLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
//        guideLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30).isActive = true
//        guideLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30).isActive = true
//        guideLabel.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -30).isActive = true


        
    }
    
}
