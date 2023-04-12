//
//  ReviewVM.swift
//  MovieApplication
//
//  Created by Oliwia Procyk on 11/04/2023.
//

import Foundation
protocol ReviewVMDelegate {
    func success()
    func error(error: String)
    func startActivityIndicator()
}

final class ReviewVM {
    var review: [Review] = []
    var delegate: ReviewVMDelegate?
    var page = 1

    func getReview(movieID: Int) {
        self.delegate?.startActivityIndicator()
        ReviewService.shared.getReview(page: page, movieId: movieID) { [weak self] response, errorMessage in
            guard let self = self else { return }
            
            if let results = response?.results {
                self.review.append(contentsOf: results)
                self.page += 1
                self.delegate?.success()
            } else {
                self.delegate?.error(error: errorMessage ?? "Something went wrong.")
            }
        }
    }
}
