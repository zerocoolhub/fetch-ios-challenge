//
//  RecipesView.swift
//  fetch-ios-challenge
//
//  Created by Varun Samuel on 9/11/24.
//

import SwiftUI

struct RecipesView: View {
    @State private var recipesVM = RecipesViewModel()
    
    var body: some View {
        self.content
            .navigationTitle("Recipes")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Fetch Recipes") {
                        self.fetchRecipesButtonPressed()
                    }
                }
            }
    }
    
    @ViewBuilder
    private var content: some View {
        if let _ = self.recipesVM.networkError {
            Text("There was an error fetching Recipes! Please try again!")
                .foregroundColor(.red)
        } else if let dessertRecipes = self.recipesVM.dessertRecipes {
            if dessertRecipes.isEmpty {
                Text("No Recipes available")
            } else {
                RecipesListView(shortRecipes: dessertRecipes)
            }
        } else {
            Text("Tap \"Fetch Recipes\" to fetch recipes")
        }
    }
    
    private struct RecipesListView: View {
        let shortRecipes: [ShortRecipe]
        
        var body: some View {
            List {
                ForEach(self.shortRecipes) { recipe in
                    if let recipeID = recipe.id,
                       let recipeName = recipe.name,
                       !recipeID.isEmpty,
                       !recipeName.isEmpty {
                        NavigationLink(destination: RecipeView(recipeVM: RecipeViewModel(recipeID: recipeID))) {
                            HStack {
                                if let thumbnailURL = recipe.thumbnailURL, let url = URL(string: thumbnailURL) {
                                    AsyncImage(url: url) { image in
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 50, height: 50)
                                            .cornerRadius(8)
                                    } placeholder: {
                                        ProgressView()
                                            .frame(width: 50, height: 50)
                                    }
                                } else {
                                    Image(systemName: "photo")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 50, height: 50)
                                        .cornerRadius(8)
                                        .foregroundStyle(.gray)
                                }
                                
                                Text(recipeName)
                                    .font(.headline)
                            }
                        }
                    }
                }
            }
        }
    }
    
    func fetchRecipesButtonPressed() {
        self.recipesVM.fetchMeals()
    }
}

struct RecipesView_Previews: PreviewProvider {
    static var previews: some View {
        RecipesView()
    }
}
