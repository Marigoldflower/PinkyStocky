//
//  MyStockList.swift
//  MyStockApp
//
//  Created by 황홍필 on 2023/03/09.
//

import Foundation


struct MyStockList: Codable {
    var codeName: String
    var detailName: String
    var priceLabel: String
    var changeLabel: Double
    var chartData: [Double] {
        didSet {
            print("주식이 들어왔으면 말 좀 해줘 ")
        }
    }
}
