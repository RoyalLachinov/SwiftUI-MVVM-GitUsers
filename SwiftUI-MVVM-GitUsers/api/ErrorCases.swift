//
//  ErrorCases.swift
//  await)
//
//  Created by Royal Lachinov on 2025-02-16.
//

import Foundation


enum ErrorCases: LocalizedError {
    case invalidUrl
    case invalidResponse
    case invalidData
    
    
    var errorDescription: String? {
        switch self {
        case .invalidUrl:
            return "Invalid URL"
        case .invalidResponse:
            return "Invalid HTTP response"
        case .invalidData:
            return "Invalid data"
        }
    }
}
