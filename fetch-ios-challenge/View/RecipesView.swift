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
        VStack {
            if self.recipesVM.networkError != nil {
                Text("There was an error fetching Recipes! Please try again!")
            } else {
                RecipesListView(shortRecipes: self.recipesVM.dessertRecipes)
            }
            
            Spacer()
        }
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
    
    private struct RecipesListView: View {
        let shortRecipes: [ShortRecipe]
        
        var body: some View {
            List {
                ForEach(self.shortRecipes) { meal in
                    NavigationLink(destination: RecipeView(recipeVM: RecipeViewModel(recipeID: meal.id))) {
                        HStack {
                            AsyncImage(url: URL(string: meal.thumbnailURL)) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 50, height: 50)
                                    .cornerRadius(8)
                            } placeholder: {
                                ProgressView()
                                    .frame(width: 50, height: 50)
                            }
                            
                            Text(meal.name)
                                .font(.headline)
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
