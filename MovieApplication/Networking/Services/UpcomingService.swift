//
//  UpcomingServices.swift
//  MovieApplication
//
//  Created by Oliwia Procyk on 24/03/2023.
//

import Foundation

class UpcomingServices {
    static let shared = UpcomingServices()
    private init(){}
    
    func getUpcomingMovies(page: Int, complition: @escaping((MoviesModel?, String?)-> ())) {
        let urlString = "\(APIConstants.baseURL)\(APIConstants.upcomingEndPoint)?api_key=\(APIConstants.apiKey)"
        
        NetworkManager.shared.request(type: MoviesModel.self,
                                      url: urlString,
                                      method: HTTPMethods.get) { response in
            switch response{
            case .success(let items):
                complition(items,nil)
            case .failure(let error):
                complition(nil,error.rawValue)
            }
        }
    }
}
