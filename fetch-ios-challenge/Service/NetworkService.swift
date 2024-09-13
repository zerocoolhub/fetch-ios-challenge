//
//  NetworkService.swift
//  fetch-ios-challenge
//
//  Created by Varun Samuel on 9/12/24.
//

import Foundation

private let DESSERT_MEALS_URL = "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert"

private struct MealResponse: Codable {
    let meals: [Meal]
}

enum NetworkError: Error {
    case invalidURL
    case decodingError
}

class NetworkService {
    func fetchMeals() async throws -> [Meal] {
        guard let url = URL(string: DESSERT_MEALS_URL) else {
            // You would log this error to logging service
            throw NetworkError.invalidURL
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        do {
            let decoder = JSONDecoder()
            let mealResponse = try decoder.decode(MealResponse.self, from: data)
            return mealResponse.meals
        } catch {
            // You would log this error to logging service
            throw NetworkError.decodingError
        }
    }
}
