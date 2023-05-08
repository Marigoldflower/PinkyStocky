//
//  MyImage.swift
//  MyStockApp
//
//  Created by 황홍필 on 2023/02/15.
//

import Foundation
import UIKit

extension UIColor {
    static let pinkBeige = UIColor(red: 0.97, green: 0.93, blue: 0.92, alpha: 1.00)
    static let autumnPink = UIColor(red: 0.92, green: 0.60, blue: 0.70, alpha: 1.00)
    static let tintPink = UIColor(red: 0.92, green: 0.39, blue: 0.55, alpha: 1.00)
    static let headerPink = UIColor(red: 0.90, green: 0.82, blue: 0.82, alpha: 1.00)
    static let dataPink = UIColor(red: 0.80, green: 0.36, blue: 0.40, alpha: 1.00)
}



extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach {
            addSubview($0)
        }
    }
}
