//
//  AllMoviesVM.swift
//  MovieApplication
//
//  Created by Oliwia Procyk on 22/03/2023.
//

import Foundation

protocol AllMoviesVMDelegate: AnyObject {
    func success()
    func error(error: String)
    func startActivityIndicator()
}

final class AllMoviesVM {
    var movies: [Movie] = []
    weak var delegate: AllMoviesVMDelegate?
    var page = 1
    
    func getPopularMovie() {
        self.delegate?.startActivityIndicator()
        PopularMoviesService.shared.getPopularMovies(page: page) { [weak self] response, errorMessage in
            guard let self = self else { return }
            if let results = response?.results {
                self.movies.append(contentsOf: results)
                self.page += 1
                self.delegate?.success()
            } else {
                self.delegate?.error(error: errorMessage ?? "Something went wrong.")
            }
        }
    }
    
    func getTopMovie() {
        self.delegate?.startActivityIndicator()
        TopRatedService.shared.getTopMovies(page: page) { [weak self] response, errorMessage in
            guard let self = self else { return }
            if let results = response?.results {
                self.movies.append(contentsOf: results)
                self.page += 1
                self.delegate?.success()
            } else {
                self.delegate?.error(error: errorMessage ?? "Something went wrong.")
            }
        }
    }
    
    func getUpcomingMovie() {
        self.delegate?.startActivityIndicator()
        UpcomingServices.shared.getUpcomingMovies(page: page) { [weak self] response, errorMessage in
            guard let self = self else { return }
            if let results = response?.results {
                self.movies.append(contentsOf: results)
                self.page += 1
                self.delegate?.success()
            } else {
                self.delegate?.error(error: errorMessage ?? "Something went wrong.")
            }
        }
    }
}

