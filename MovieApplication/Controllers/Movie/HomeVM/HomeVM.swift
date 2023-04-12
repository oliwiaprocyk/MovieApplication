//
//  MovieVM.swift
//  MovieApplication
//
//  Created by Oliwia Procyk on 17/03/2023.
//

import Foundation

protocol HomeVMDelegate: AnyObject {
    func success()
    func error(error: String)
    func startActivityIndicator()
}

final class HomeVM {
    var popularMovies: [Movie] = []
    var topMovies: [Movie] = []
    var upcomingMovies: [Movie] = []
    var nowPlayingMovies: [Movie] = []
    weak var delegate: HomeVMDelegate?
    var page = 1
    
    func getPopularMovie() {
        self.delegate?.startActivityIndicator()
        PopularMoviesService.shared.getPopularMovies(page: page) { [weak self] response, errorMessage in
            guard let self = self else { return }
            if let results = response?.results {
                self.popularMovies.append(contentsOf: results)
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
                self.topMovies.append(contentsOf: results)
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
                self.upcomingMovies.append(contentsOf: results)
                self.page += 1
                self.delegate?.success()
            } else {
                self.delegate?.error(error: errorMessage ?? "Something went wrong.")
            }
        }
    }
    
    func getNowPlayingMovie() {
        self.delegate?.startActivityIndicator()
        NowPlayingService.shared.getNowPlayingMovies(page: page) { [weak self] response, errorMessage in
            guard let self = self else { return }
            if let results = response?.results {
                self.nowPlayingMovies.append(contentsOf: results)
                self.page += 1
                self.delegate?.success()
            } else {
                self.delegate?.error(error: errorMessage ?? "Something went wrong.")
            }
        }
    }
}
