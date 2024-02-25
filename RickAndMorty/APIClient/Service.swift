//
//  Service.swift
//  RickAndMorty
//
//  Created by Dmitrii Iakovlev on 22.02.2024.
//

import Foundation
     
final class Service {
    
    static let shared = Service()
    private init() {}
    
    enum serviceError: Error {
        case failedToCreateRequest
        case failedToGetData
    }
    
    
    public func execute<T: Codable>(_ request: Request,
                                    expecting type: T.Type,
                                    completion: @escaping (Result<T, Error>) -> Void) {
        
        guard let urlRequest = self.request(from: request) else {
            completion(.failure(serviceError.failedToCreateRequest))
            return
        }
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? serviceError.failedToGetData))
                return
            }
            
            do {
                let result = try JSONDecoder().decode(type.self, from: data)
                completion(.success(result))
            }
            catch {
                completion(.failure(error))
            } 
        }
        task.resume()
        
    }
    
    private func request(from rmRequest: Request) -> URLRequest? {
        guard let url = rmRequest.url else { return nil }
        
        var request = URLRequest(url: url)
        request.httpMethod = rmRequest.httpMethod
        
        return request
    }
}
