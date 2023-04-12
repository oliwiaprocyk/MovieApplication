//
//  TrailersService.swift
//  MovieApplication
//
//  Created by Oliwia Procyk on 28/03/2023.
//

import Foundation

class TrailersService {
    static let shared = TrailersService()
    private init(){}
    
    func getTrailers(movieID: Int, completion: @escaping((TrailersModel?, String?)->())) {
        let urlString = "\(APIConstants.baseURL)\(APIConstants.detailEndPoint)\(movieID)\(APIConstants.trailersEndPoint)?api_key=\(APIConstants.apiKey)"
        NetworkManager.shared.request(type: TrailersModel.self,
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
