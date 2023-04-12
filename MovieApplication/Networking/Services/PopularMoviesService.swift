//
//  PopularMoviesService.swift
//  MovieApplication
//
//  Created by Oliwia Procyk on 17/03/2023.
//

import Foundation

class PopularMoviesService {
    static let shared = PopularMoviesService()
    private init(){}
    
    func getPopularMovies(page: Int, completion: @escaping((MoviesModel?, String?) -> ())) {
        let urlString = "\(APIConstants.baseURL)\(APIConstants.popularMovieEndPoint)?api_key=\(APIConstants.apiKey)&page=\(page)"
        
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
