//
//  NetworkManager.swift
//  MovieApplication
//
//  Created by Oliwia Procyk on 17/03/2023.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    private init(){}
    
    func request<T: Codable>(type: T.Type,
                             url: String,
                             method: HTTPMethods,
                             completion: @escaping ((Result<T, ErrorTypes>) -> ())) {
        
        if let url = URL(string: url) {
            var request = URLRequest(url: url)
            request.httpMethod = method.rawValue
            
            let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
                if let _ = error {
                    completion(.failure(.generalError))
                } else if let data = data {
                    self.handlerResponse(data: data) { response in
                        completion(response)
                    }
                } else {
                    completion(.failure(.invalidUrl))
                }
            }
            dataTask.resume()
        }
    }
    private func handlerResponse<T: Codable>(data: Data,
                                             completion: @escaping((Result<T, ErrorTypes>) -> ())) {
        do {
            let result = try JSONDecoder().decode(T.self, from: data)
            completion(.success(result))
        } catch {
            completion(.failure(.invalidData))
        }
    }
}
