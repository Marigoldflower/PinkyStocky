//
//  LoadingView.swift
//  MyStockApp
//
//  Created by 황홍필 on 2023/03/22.
//

import UIKit

final class LoadingView: UIView {
    
    
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
    
    
    private func setupConstraints() {
        
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
    
    private func animate() {
        for index in 0..<loadingCirclesCollection.count {
            // scale을 이용하여 원의 넓이와 높이를 아주 살짝 증가시켰다.
            loadingCirclesCollection[index].transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
            // 설정해놓은 원들이 계속 움직이도록 만들었다. (repeat, autoreverse)
            // autoreverse는 애니메이션을 반대로도 실행할 수 있게 하는 구문
            UIView.animate(withDuration: 0.6, delay: Double(index + 1) * 0.2, options: [.repeat, .autoreverse]) {
                self.loadingCirclesCollection[index].transform = CGAffineTransform.identity
            }
        }
    }
}
