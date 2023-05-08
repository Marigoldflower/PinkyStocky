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
    static let dataPink = UIColor(red: 0.90, green: 0.82, blue: 0.82, alpha: 0.5)
    static let headerPink = UIColor(red: 0.80, green: 0.36, blue: 0.40, alpha: 1.00)
    static let autumnBlue = UIColor(red: 0.51, green: 0.76, blue: 0.84, alpha: 1.00)
    static let dataGreen = UIColor(red: 0.55, green: 0.70, blue: 0.41, alpha: 1.00)
    static let dataBlue = UIColor(red: 0.62, green: 0.71, blue: 0.75, alpha: 1.00)
    static let dataBeige = UIColor(red: 0.96, green: 0.95, blue: 0.93, alpha: 1.00)
}



extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach {
            addSubview($0)
        }
    }
}


extension UserDefaults {
    var userDataList: [MyStockList] {
        get {
            guard let data = UserDefaults.standard.data(forKey: "userDataList") else { return [] }
            return (try? PropertyListDecoder().decode([MyStockList].self, from: data)) ?? []
        }
        set {
            UserDefaults.standard.set(try? PropertyListEncoder().encode(newValue), forKey: "userDataList")
        }
    }
}




extension UIImage {
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage? {
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(origin: .zero, size: newSize)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
}


extension UITableView {

    func setMessage(_ message: String) {
        let lblMessage = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        lblMessage.text = message
        lblMessage.textColor = .headerPink
        lblMessage.numberOfLines = 0
        lblMessage.textAlignment = .center
        lblMessage.sizeToFit()
        lblMessage.font = .boldSystemFont(ofSize: 14)
        self.backgroundView = lblMessage
        self.separatorStyle = .none
    }

    func clearBackground() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}

