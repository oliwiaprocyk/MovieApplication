//
//  CastService.swift
//  MovieApplication
//
//  Created by Oliwia Procyk on 07/04/2023.
//

import Foundation

class CastService {
    static let shared = CastService()
    private init(){}
    
    func getCast(movieID: Int, completion: @escaping((CastModel?, String?)->())) {
        let urlString = "\(APIConstants.baseURL)\(APIConstants.detailEndPoint)\(movieID)\(APIConstants.castEndPoint)?api_key=\(APIConstants.apiKey)"
        NetworkManager.shared.request(type: CastModel.self,
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
