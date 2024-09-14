//
//  RecipeView.swift
//  fetch-ios-challenge
//
//  Created by Varun Samuel on 9/12/24.
//

import SwiftUI

struct RecipeView: View {
    @State var recipeVM: RecipeViewModel
    
    var body: some View {
        VStack {
            if  self.recipeVM.networkError != nil {
                Text("There was an error fetching the recipe.")
            } else if let fullRecipe = self.recipeVM.fullRecipe {
                RecipeCardView(fullRecipe: fullRecipe)
            }
        }
        .navigationTitle("Recipe")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            self.recipeVM.fetchRecipe()
        }
    }
    
    private struct RecipeCardView: View {
        let fullRecipe: FullRecipe
        
        var body: some View {
            ScrollView {
                VStack {
                    Text(self.fullRecipe.recipeName ?? "This recipe has no name")
                        .font(.title)
                        .padding(.bottom)
                    
                    Text(self.fullRecipe.recipeInstructions ?? "This recipe has no associated instructions")
                        .font(.subheadline)
                    
                    Spacer()
                        .frame(height: 20)
                    
                    if self.fullRecipe.ingredients.count > 0 {
                        Text("Ingredients")
                            .font(.headline)
                        
                        LazyVStack(alignment: .leading, spacing: 10) {
                            ForEach(self.fullRecipe.ingredients) { ingredients in
                                HStack  {
                                    Text(ingredients.ingredient)
                                    
                                    Spacer()
                                    
                                    Text(ingredients.measure)
                                }
                            }
                        }
                    } else {
                        Text("This recipe has no associated ingredients")
                    }
                }
                .padding()
            }
        }
    }
}
