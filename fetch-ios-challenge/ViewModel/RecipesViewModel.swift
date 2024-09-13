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
    var dessertMeals: [Meal] = []
    var networkError: Error?
    
    func fetchMeals() {
        Task {
            do {
                let meals = try await self.networkService.fetchMeals()
                let sortedMeals = meals.sorted { $0.name.lowercased() < $1.name.lowercased() }
                self.dessertMeals = sortedMeals
            } catch {
                self.networkError = error
            }
        }
    }
}
