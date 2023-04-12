//
//  DetailsService.swift
//  MovieApplication
//
//  Created by Oliwia Procyk on 24/03/2023.
//

import Foundation

class DetailsService {
    static let shared = DetailsService()
    private init(){}
        
    func getMovieDetail(movieID: Int, complition: @escaping((DetailsModel?, String?)-> ())) {
        let urlString = "\(APIConstants.baseURL)\(APIConstants.detailEndPoint)\(movieID)?api_key=\(APIConstants.apiKey)"
        NetworkManager.shared.request(type: DetailsModel.self,
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
