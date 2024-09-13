//
//  NetworkService.swift
//  fetch-ios-challenge
//
//  Created by Varun Samuel on 9/12/24.
//

import Foundation

private let DESSERT_MEALS_URL = "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert"
private let MEAL_URL = "https://themealdb.com/api/json/v1/1/lookup.php?i="

private struct RecipesResponse: Codable {
    let meals: [Recipe]
}

enum NetworkError: Error {
    case invalidURL
    case decodingError
}

class NetworkService {
    func fetchRecipes() async throws -> [Recipe] {
        guard let url = URL(string: DESSERT_MEALS_URL) else {
            // You would log this error to logging service
            throw NetworkError.invalidURL
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        do {
            let decoder = JSONDecoder()
            let mealResponse = try decoder.decode(RecipesResponse.self, from: data)
            return mealResponse.meals
        } catch {
            // You would log this error to logging service
            throw NetworkError.decodingError
        }
    }
}
