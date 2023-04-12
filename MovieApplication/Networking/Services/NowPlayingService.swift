//
//  NowPlayingService.swift
//  MovieApplication
//
//  Created by Oliwia Procyk on 21/03/2023.
//

import Foundation

class NowPlayingService {
    static let shared = NowPlayingService()
    private init(){}
    
    func getNowPlayingMovies(page: Int, completion: @escaping((MoviesModel?, String?) -> ())) {
        let urlString = "\(APIConstants.baseURL)\(APIConstants.nowPlayingEndPoint)?api_key=\(APIConstants.apiKey)"
        
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
