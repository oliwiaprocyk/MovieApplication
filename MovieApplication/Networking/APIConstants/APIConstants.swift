//
//  APIConstants.swift
//  MovieApplication
//
//  Created by Oliwia Procyk on 17/03/2023.
//

import Foundation

class APIConstants {
    static let baseURL               = "https://api.themoviedb.org/3"
    static let apiKey                = "d01c48435a43627d2ac87bf0d9e756ee"
    static let popularMovieEndPoint  = "/movie/popular"
    static let topRatedEndPoint      = "/movie/top_rated"
    static let upcomingEndPoint      = "/movie/upcoming"
    static let nowPlayingEndPoint    = "/movie/now_playing"
    static let detailEndPoint        = "/movie/"
    static let trailersEndPoint      = "/videos"
    static let castEndPoint          = "/credits"
    static let similarMoviesEndPoint = "/similar"
    static let reviewMovieEndPoint   = "/reviews"
}
