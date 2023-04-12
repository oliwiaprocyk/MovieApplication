//
//  DetailsModel.swift
//  MovieApplication
//
//  Created by Oliwia Procyk on 24/03/2023.
//

import Foundation

struct DetailsModel: Codable {
    let title: String?
    let overview: String?
    let posterPath: String?
    let backdropPath: String?
    let originalTitle: String?
    let tagline: String?
    let status: String?
    let revenue: Int?
    let voteAverage: Double?
    let originalLanguage: String?
    let releaseDate: String?
    let productionCountries: [Country]?
    let genres: [Genre]?

    
    enum CodingKeys: String, CodingKey {
        case title
        case overview
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case originalTitle = "original_title"
        case tagline
        case status
        case revenue
        case voteAverage = "vote_average"
        case originalLanguage = "original_language"
        case releaseDate = "release_date"
        case productionCountries = "production_countries"
        case genres
    }
}
struct Country: Codable {
    let iso31661: String?

    enum CodingKeys: String, CodingKey {
        case iso31661 = "iso_3166_1"
    }
}
struct Genre: Codable {
    let id: Int?
    let name: String?
}
