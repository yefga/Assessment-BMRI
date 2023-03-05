//
//  APIError.swift
//  AssignmentNetwork
//
//  Created by yepz on 05/03/23.
//

import Foundation

enum APIError: Error {
    case decodeFailed
    case dataFailed
    case networkFailed
    case urlNotFound
    case defaultError
    
    var errorDescription: String {
        switch self {
        case .dataFailed: return "Failed to convert data"
        case .networkFailed: return "Failed to connect to network"
        case .decodeFailed: return "Failed to decode json"
        case .urlNotFound: return "URL not found"
        case .defaultError: return "Error has been happened"
        }
    }
}
