//
//  ReviewService.swift
//  MovieApplication
//
//  Created by Oliwia Procyk on 11/04/2023.
//

import Foundation

class ReviewService {
    static let shared = ReviewService()
    private init(){}
    
    func getReview(page: Int, movieId: Int, completion: @escaping((ReviewModel?, String?)->())) {
        let urlString = "\(APIConstants.baseURL)\(APIConstants.detailEndPoint)\(movieId)\(APIConstants.reviewMovieEndPoint)?api_key=\(APIConstants.apiKey)"
        NetworkManager.shared.request(type: ReviewModel.self,
                                      url: urlString,
                                      method: HTTPMethods.get) { response in
            switch response{
            case .success(let items):
                completion(items,nil)
            case .failure(let error):
                completion(nil,error.rawValue)
            }
        }
    }
}
