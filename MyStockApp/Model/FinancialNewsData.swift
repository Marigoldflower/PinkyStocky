//
//  GeneralNewsData.swift
//  MyStockApp
//
//  Created by 황홍필 on 2023/03/18.
//

import Foundation


struct FinancialNewsData: Codable {
    let category: String
    let datetime: Int
    let headline: String
    let summary: String
    var image: String
    let publisher: String
    let url: String
    
    
    enum CodingKeys: String, CodingKey {
       case category
       case datetime
       case headline
       case summary
       case image
       case publisher = "source"
       case url
    }
    
    var dateTimeFormatter: String? {
        let formatter = DateFormatter()
        let epochTime = TimeInterval(datetime)
        let date = Date(timeIntervalSince1970: epochTime)
        formatter.dateFormat = "yyyy-MM-dd"
        let result = formatter.string(from: date)
        
        return result
    }
    
    
    var imageSDURL: URL? {
        guard let url = URL(string: image) else { return URL(string: "") }
        return url
    }
    
}

typealias NewsCollection = [FinancialNewsData]
