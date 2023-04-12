//
//  TrailersModel.swift
//  MovieApplication
//
//  Created by Oliwia Procyk on 28/03/2023.
//

import Foundation

struct TrailersModel: Codable {
    let id: Int?
    let results: [Trailer]?
}

struct Trailer: Codable {
    let name: String?
    let key: String?
    let publishedAt: String?
    let id: String?

    enum CodingKeys: String, CodingKey {
        case name
        case key
        case publishedAt = "published_at"
        case id
    }
}
