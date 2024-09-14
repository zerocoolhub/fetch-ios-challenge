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
    let meals: [ShortRecipe]
}

private struct RecipeResponse: Codable {
    let meals: [FullRecipe]
}

enum NetworkError: Error {
    case invalidURL
    case decodingError
}

class NetworkService {
    func fetchRecipes() async throws -> [ShortRecipe] {
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
    
    func fetchRecipe(recipeID: String) async throws -> FullRecipe {
        let fullURL = MEAL_URL + recipeID
        guard let url = URL(string: fullURL) else {
            // You would log this error to logging service
            throw NetworkError.invalidURL
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        do {
            let decoder = JSONDecoder()
            let recipeResponse = try decoder.decode(RecipeResponse.self, from: data)
            let fullRecipe = recipeResponse.meals[0]
            
            return fullRecipe
        } catch {
            print(error)
            // You would log this error to logging service
            throw NetworkError.decodingError
        }
    }
}
