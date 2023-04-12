//
//  ReviewModel.swift
//  MovieApplication
//
//  Created by Oliwia Procyk on 11/04/2023.
//

import Foundation

struct ReviewModel: Codable {
    let results: [Review]?
}

struct Review: Codable {
    let author: String?
    let content: String?
    let authorDetails: AuthorDetails?
    let createdAt: String?
    
    enum CodingKeys: String, CodingKey {
        case author
        case content
        case authorDetails = "author_details"
        case createdAt = "created_at"
    }
}

struct AuthorDetails: Codable {
    let rating: Double?
}

