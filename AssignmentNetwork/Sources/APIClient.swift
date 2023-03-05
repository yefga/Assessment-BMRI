//
//  APIClient.swift
//  AssignmentNetwork
//
//  Created by yepz on 05/03/23.
//

import Foundation
import Alamofire

public protocol APIClientProtocol {
    func request<T: Codable>(
        url: URLRequestConvertible,
        forModel model: T.Type,
        completion: @escaping ((Result<T, Error>) -> Void)
    )
}

public final class APIClient: APIClientProtocol {
    public init() {}
    
    public func request<T: Codable>(
        url: URLRequestConvertible,
        forModel model: T.Type,
        completion: @escaping ((Result<T, Error>) -> Void)
    ) {
    
        let manager = Session.default
        let request = manager.request(url)
        
        request
            .validate()
            .response { response in
                switch response.response?.statusCode {
                case .some(200..<300):
                    if let data = response.data {
                        if let result = try? JSONDecoder().decode(model.self, from: data) {
                            completion(.success(result))
                        } else {
                            completion(.failure(APIError.decodeFailed))
                        }
                    } else {
                        completion(.failure(APIError.dataFailed))
                    }
                case .some(400..<500):
                    completion(.failure(APIError.networkFailed))
                default:
                    completion(.failure(APIError.networkFailed))
                }
            }
                
    }
}
