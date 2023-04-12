//
//  SimilarMoviesService.swift
//  MovieApplication
//
//  Created by Oliwia Procyk on 07/04/2023.
//

import Foundation

class SimilarMoviesService {
    static let shared = SimilarMoviesService()
    private init(){}
    
    func getSimilarMovies(movieId: Int, completion: @escaping((MoviesModel?, String?)->())) {
        let urlString = "\(APIConstants.baseURL)\(APIConstants.detailEndPoint)\(movieId)\(APIConstants.similarMoviesEndPoint)?api_key=\(APIConstants.apiKey)"
        NetworkManager.shared.request(type: MoviesModel.self,
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
