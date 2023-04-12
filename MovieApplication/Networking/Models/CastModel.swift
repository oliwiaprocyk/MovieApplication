//
//  CastModel.swift
//  MovieApplication
//
//  Created by Oliwia Procyk on 07/04/2023.
//

import Foundation

struct CastModel: Codable {
    let id: Int?
    let cast: [Cast]?
}

struct Cast: Codable {
    let id: Int?
    let name: String?
    let profilePath: String?
    let character: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case profilePath = "profile_path"
        case character
    }
}
