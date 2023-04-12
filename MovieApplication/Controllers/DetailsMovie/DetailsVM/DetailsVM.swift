//
//  DetailsVM.swift
//  MovieApplication
//
//  Created by Oliwia Procyk on 24/03/2023.
//

import Foundation

protocol DetailsVMDelegate: AnyObject {
    func successDetails()
    func error(error: String)
    func success()
    func startActivityIndicator()
}

final class DetailsVM {
    weak var delegate: DetailsVMDelegate?
    var movie: DetailsModel?
    var similarMovies: [Movie] = []
    var trailers: [Trailer] = []
    var cast: [Cast] = []
    var movieID: Int?
    
    func getMovieDetail(movieID: Int) {
        self.delegate?.startActivityIndicator()
        DetailsService.shared.getMovieDetail(movieID: movieID) { [weak self] response, errorMessage in
            guard let self = self else { return }
            
            if let response = response {
                self.movie = response
                self.delegate?.successDetails()
            } else {
                self.delegate?.error(error: errorMessage ?? "Something went wrong.")
            }
        }
    }
    
    func getTrailers(movieID: Int) {
        self.delegate?.startActivityIndicator()
        TrailersService.shared.getTrailers(movieID: movieID) { [weak self] response, errorMessage in
            guard let self = self else { return }
            
            if let results = response?.results {
                self.trailers = results
                self.delegate?.success()
            } else {
                self.delegate?.error(error: errorMessage ?? "Something went wrong.")
            }
        }
    }
    
    func getCast(movieID: Int) {
        self.delegate?.startActivityIndicator()
        CastService.shared.getCast(movieID: movieID) { [weak self] response, errorMessage in
            guard let self = self else { return }
            
            if let results = response?.cast {
                self.cast = results
                self.delegate?.success()
            } else {
                self.delegate?.error(error: errorMessage ?? "Something went wrong.")
            }
        }
    }
    
    func getSimilarMovies(movieID: Int) {
        self.delegate?.startActivityIndicator()
        SimilarMoviesService.shared.getSimilarMovies(movieId: movieID) { [weak self] response, errorMessage in
            guard let self = self else { return }
            
            if let results = response?.results {
                self.similarMovies = results
                self.delegate?.success()
            }
        }
    }
}
