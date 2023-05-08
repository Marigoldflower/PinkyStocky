//
//  TopNewsView.swift
//  MyStockApp
//
//  Created by 황홍필 on 2023/04/04.
//



import Foundation

// MARK: - TopNews
struct TopNews: Codable {
    let topNewsData: [TopNewsData]
    
    enum CodingKeys: String, CodingKey {
       case topNewsData = "articles"
    }
}

// MARK: - Article
struct TopNewsData: Codable {
    let author: String
    let newsTitle: String
    let newsDescription: String
    let url: String
    let imageURL: String
    
    
    enum CodingKeys: String, CodingKey {
        case author
        case newsTitle = "title"
        case newsDescription = "description"
        case url
        case imageURL = "urlToImage"

    }
    
    
    var imageSDURL: URL? {
        guard let url = URL(string: imageURL ?? "") else { return URL(string: "") }
        return url
    }
    
}

// MARK: - Source
struct Source: Codable {
    let id: ID
    let name: Name
}

enum ID: String, Codable {
    case techcrunch = "techcrunch"
}

enum Name: String, Codable {
    case techCrunch = "TechCrunch"
}
