//
//  Recipe.swift
//  fetch-ios-challenge
//
//  Created by Varun Samuel on 9/12/24.
//

import Foundation

struct ShortRecipe: Codable, Identifiable {
    let name: String
    let thumbnailURL: String
    let id: String
    
    enum CodingKeys: String, CodingKey {
        case name = "strMeal"
        case thumbnailURL = "strMealThumb"
        case id = "idMeal"
    }
}
