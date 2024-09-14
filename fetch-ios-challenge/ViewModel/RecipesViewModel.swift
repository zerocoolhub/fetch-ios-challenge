//
//  RecipesViewModel.swift
//  fetch-ios-challenge
//
//  Created by Varun Samuel on 9/11/24.
//

import Foundation

@Observable
class RecipesViewModel {
    let networkService = NetworkService()
    var dessertRecipes: [ShortRecipe] = []
    var networkError: Error?
    
    func fetchMeals() {
        Task {
            do {
                let meals = try await self.networkService.fetchRecipes()
                let sortedRecipes = meals.sorted { $0.name.lowercased() < $1.name.lowercased() }
                self.dessertRecipes = sortedRecipes
                self.networkError = nil
            } catch {
                self.networkError = error
            }
        }
    }
}
