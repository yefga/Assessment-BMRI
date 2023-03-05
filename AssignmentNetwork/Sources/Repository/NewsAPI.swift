//
//  NewsAPI.swift
//  AssignmentNetwork
//
//  Created by yepz on 05/03/23.
//

import Alamofire
import Foundation

public enum NewsAPI: APIConfig {
    case fetch(category: String, page: Int)
    
    public var path: String {
        switch self {
        case .fetch:
            return "/top-headlines"
        }
    }
    
    public var parameters: Parameters? {
        switch self {
        case .fetch(let categor, let page):
            return [
                "apiKey": newsKey,
                "page": "\(page)",
                "category": categor,
                "country": "id"
            ]
        }
    }
    
    public var methods: HTTPMethod {
        return .get
    }
}
