//
//  NewYorkTimesJournalData.swift
//  MyStockApp
//
//  Created by 황홍필 on 2023/03/25.
//// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let journal = try? JSONDecoder().decode(Journal.self, from: jsonData)


import Foundation

// MARK: - Journal
struct Journal: Codable {
    let results: [Result]
    let nextPage: String
}

// MARK: - Result
struct Result: Codable {
    let title: String
    let link: String
    let keywords, creator: [String]
    let videoURL: JSONNull?
    let description, content, pubDate: String
    let imageURL: String?
    let sourceID: SourceID
    let category: [Category]
    let country: [Country]
    let language: Language

    enum CodingKeys: String, CodingKey {
        case title, link, keywords, creator
        case videoURL = "video_url"
        case description, content, pubDate
        case imageURL = "image_url"
        case sourceID = "source_id"
        case category, country, language
    }
}

enum Category: String, Codable {
    case business = "business"
}

enum Country: String, Codable {
    case unitedStatesOfAmerica = "united states of america"
}

enum Language: String, Codable {
    case english = "english"
}

enum SourceID: String, Codable {
    case cointelegraph = "cointelegraph"
    case forbes = "forbes"
    case reviewjournal = "reviewjournal"
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
