//
//  FullRecipe.swift
//  fetch-ios-challenge
//
//  Created by Varun Samuel on 9/13/24.
//

import Foundation

struct FullRecipe: Codable {
    struct IngredientMeasure: Identifiable {
        let id: String
        let ingredient: String
        let measure: String
        
        init(ingredient: String, measure: String) {
            self.id = UUID().uuidString
            self.ingredient = ingredient
            self.measure = measure
        }
    }
    
    private let rawDict: [String: String?]
    
    var ingredientMeasures: [IngredientMeasure] {
        var result: [IngredientMeasure] = []
        for i in 1... {
            guard let ingredient = rawDict["strIngredient\(i)"] ?? nil,
                  let measure = rawDict["strMeasure\(i)"] ?? nil,
                  !ingredient.isEmpty else {
                break
            }
            result.append(IngredientMeasure(ingredient: ingredient, measure: measure))
        }
        return result
    }
    
    var recipeName: String? {
        return self.rawDict["strMeal"] ?? nil
    }
    
    var recipeInstructions: String? {
        return self.rawDict["strInstructions"] ?? nil
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.rawDict = try container.decode([String: String?].self)
    }
}
