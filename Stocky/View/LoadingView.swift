//
//  LoadingView.swift
//  MyStockApp
//
//  Created by 황홍필 on 2023/03/22.
//

import UIKit

class LoadingView: UIView {
    
    
    // MARK: - 로딩 중을 표현하는 뷰
    
    
    lazy var loadingCirclesCollection: [UIView] = [loadingCircle1, loadingCircle2, loadingCircle3]
    

    let loadingCircle1: UIView = {
        let view = UIView()
        view.backgroundColor = .headerPink
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()
    
    let loadingCircle2: UIView = {
        let view = UIView()
        view.backgroundColor = .headerPink
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()
    
    let loadingCircle3: UIView = {
        let view = UIView()
        view.backgroundColor = .headerPink
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()
    
    
    lazy var circleStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [loadingCircle1, loadingCircle2, loadingCircle3])
        stack.axis = .horizontal
        stack.spacing = 5
        return stack
    }()
   
    
    
    // MARK: - 로딩 중 글씨
    
    
    let loadingLabel: UILabel = {
        let label = UILabel()
        let stringOne = "Loading...☺️"
        let stringTwo = "Loading"
        
        let range = (stringOne as NSString).range(of: stringTwo)
        
        
        let attributedText = NSMutableAttributedString.init(string: stringOne)
        attributedText.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.headerPink, range: range)
        label.attributedText = attributedText
        
        label.font = .boldSystemFont(ofSize: 16)
        label.numberOfLines = 0
        label.textAlignment = .center
        
        return label
    }()
    
    
    
    
    
    // MARK: - 총 스택 뷰
    
    
  
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(loadingLabel)
        self.addSubview(circleStackView)
        setupConstraints()
        animate()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    func setupConstraints() {
        
        loadingCircle1.translatesAutoresizingMaskIntoConstraints = false
        
        loadingCircle1.widthAnchor.constraint(equalToConstant: 8).isActive = true
        loadingCircle1.heightAnchor.constraint(equalToConstant: 8).isActive = true
        
        
        loadingCircle2.translatesAutoresizingMaskIntoConstraints = false
        
        loadingCircle2.widthAnchor.constraint(equalToConstant: 8).isActive = true
        loadingCircle2.heightAnchor.constraint(equalToConstant: 8).isActive = true
        
        
        loadingCircle3.translatesAutoresizingMaskIntoConstraints = false
        
        loadingCircle3.widthAnchor.constraint(equalToConstant: 8).isActive = true
        loadingCircle3.heightAnchor.constraint(equalToConstant: 8).isActive = true
        
        
        
        loadingLabel.translatesAutoresizingMaskIntoConstraints = false
        
        loadingLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        loadingLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        
        circleStackView.translatesAutoresizingMaskIntoConstraints = false
        
        circleStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        circleStackView.topAnchor.constraint(equalTo: loadingLabel.bottomAnchor, constant: 10).isActive = true
        
    }
    
    func animate() {
        for index in 0..<loadingCirclesCollection.count {
            loadingCirclesCollection[index].transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
            UIView.animate(withDuration: 0.6, delay: Double(index + 1) * 0.2, options: [.repeat, .autoreverse]) {
                self.loadingCirclesCollection[index].transform = CGAffineTransform.identity
            }
        }
    }
}
