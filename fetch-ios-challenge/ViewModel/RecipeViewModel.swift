//
//  RecipeViewModel.swift
//  fetch-ios-challenge
//
//  Created by Varun Samuel on 9/13/24.
//

import Foundation

@Observable
class RecipeViewModel {
    let recipeID: String
    
    let networkService = NetworkService()
    var fullRecipe: FullRecipe?
    var networkError: Error?
    
    init(recipeID: String) {
        self.recipeID = recipeID
    }
    
    func fetchRecipe() {
        Task {
            do {
                let fullRecipe = try await self.networkService.fetchRecipe(recipeID: self.recipeID)
                self.fullRecipe = fullRecipe
                self.networkError = nil
            } catch {
                self.fullRecipe =  nil
                self.networkError = error
            }
        }
    }
}
