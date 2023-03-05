//
//  APIConfig.swift
//  AssignmentNetwork
//
//  Created by yepz on 05/03/23.
//

import Alamofire
import Foundation

public protocol APIConfig: URLRequestConvertible {
    var baseURL: String { get }
    var methods: HTTPMethod { get }
    var path: String { get }
    var parameters: Parameters? { get }
    var parameterEncoding: ParameterEncoding { get }
}

public extension APIConfig {
    var baseURL: String {
        return "https://newsapi.org/v2"
    }
    
    var methods: HTTPMethod {
        return .get
    }

    var parameters: Parameters? {
        return nil
    }
    
    var parameterEncoding: ParameterEncoding {
        return Alamofire.URLEncoding.default
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = baseURL + path
        let urlRequest = try URLRequest(url: url, method: methods, headers: nil)
        return try parameterEncoding.encode(urlRequest, with: parameters)
    }
}
