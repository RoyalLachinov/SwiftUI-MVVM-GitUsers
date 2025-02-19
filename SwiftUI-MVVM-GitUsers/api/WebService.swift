//
//  WebService.swift
//  await)
//
//  Created by Royal Lachinov on 2025-02-16.
//

import Foundation

final class WebService {
    static func getUsersData() async throws -> [UserModel] {
        let apiUrl = "https://api.github.com/users"
        
        guard let url = URL(string: apiUrl) else {
            throw ErrorCases.invalidUrl
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw ErrorCases.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            return try decoder.decode([UserModel].self, from: data)
        } catch {
            throw ErrorCases.invalidData
        }
    }
}
