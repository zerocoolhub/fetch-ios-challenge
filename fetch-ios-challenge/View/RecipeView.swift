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
        self.content
            .navigationTitle("Recipe")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                self.recipeVM.fetchRecipe()
            }
    }
    
    @ViewBuilder
    private var content: some View {
        if let _ = self.recipeVM.networkError {
            Text("There was an error fetching the recipe.")
                .foregroundColor(.red)
        } else if let fullRecipe = self.recipeVM.fullRecipe {
            FullRecipeView(fullRecipe: fullRecipe)
        } else {
            ProgressView()
        }
    }
    
    private struct FullRecipeView: View {
        let fullRecipe: FullRecipe
        
        var body: some View {
            if let recipeName = self.fullRecipe.recipeName,
               !recipeName.isEmpty,
               let recipeInstructions = self.fullRecipe.recipeInstructions,
               !recipeInstructions.isEmpty,
               !self.fullRecipe.ingredients.isEmpty {
                
                ScrollView {
                    VStack {
                        Text(recipeName)
                            .font(.title)
                            .padding(.bottom)
                        
                        Text(recipeInstructions)
                            .font(.subheadline)
                        
                        Spacer()
                            .frame(height: 20)
                        
                        
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
                    }
                    .padding()
                }
            } else {
                Text("This recipe is missing some elements. Please pick another one.")
            }
        }
    }
}
