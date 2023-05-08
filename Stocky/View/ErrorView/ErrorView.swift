//
//  ErrorView.swift
//  MyStockApp
//
//  Created by 황홍필 on 2023/02/23.
//

import UIKit

class ErrorView: UIView {
    
    
    let emptyLabel: UILabel = {
        let label = UILabel()
        let stringOne = "Sorry No Data Found 😔"
        let stringTwo = "Sorry"
        
        let range = (stringOne as NSString).range(of: stringTwo)
        
        
        let attributedText = NSMutableAttributedString.init(string: stringOne)
        attributedText.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.systemPink, range: range)
        label.attributedText = attributedText
        
        label.font = .boldSystemFont(ofSize: 18)
        label.numberOfLines = 0
        label.textAlignment = .center
        
        return label
    }()
    
    
    let goBackButton: UIButton = {
        let button = UIButton()
        button.setTitle("Go Back?", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .autumnPink
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        return button
    }()


    lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [emptyLabel, goBackButton])
        stack.spacing = 27
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fill
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(stackView)
        
        
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func updateConstraints() {
        setConstraints() // 오토레이아웃 관련 코드
        super.updateConstraints()
    }
    
    
    
    func setConstraints() {
        
        
        goBackButton.translatesAutoresizingMaskIntoConstraints = false
        
        goBackButton.widthAnchor.constraint(equalToConstant: 80).isActive = true

        
        
        
        stackView.translatesAutoresizingMaskIntoConstraints = false

        stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        


        
    }
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
}
