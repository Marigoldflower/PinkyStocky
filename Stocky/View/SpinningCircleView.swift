//
//  SpinningCircleView.swift
//  MyStockApp
//
//  Created by 황홍필 on 2023/03/22.
//

import UIKit

class SpinningCircleView: UIView {

    let spinningCircle = CAShapeLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure() {
        frame = CGRect(x: 0, y: 0, width: 110, height: 110)
        
        let rect = self.bounds
        let circularPath = UIBezierPath(ovalIn: rect)
        
        spinningCircle.path = circularPath.cgPath
        spinningCircle.fillColor = UIColor.clear.cgColor
        spinningCircle.strokeColor = UIColor.headerPink.cgColor
        spinningCircle.lineWidth = 6
        spinningCircle.strokeEnd = 0.25
        spinningCircle.lineCap = .round
        
        self.layer.addSublayer(spinningCircle)
    }

}
