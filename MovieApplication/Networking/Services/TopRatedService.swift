//
//  TopRatedService.swift
//  MovieApplication
//
//  Created by Oliwia Procyk on 21/03/2023.
//

import Foundation

class TopRatedService {
    static let shared = TopRatedService()
    private init(){}
    
    func getTopMovies(page: Int, completion: @escaping((MoviesModel?, String?) -> ())) {
        let urlString = "\(APIConstants.baseURL)\(APIConstants.topRatedEndPoint)?api_key=\(APIConstants.apiKey)"
        
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
