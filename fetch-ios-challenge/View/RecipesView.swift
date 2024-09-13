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
            Button("Fetch Recipes") {
                self.fetchRecipesButtonPressed()
            }
            .padding()
            .background(Color.blue)
            .foregroundStyle(.white)
            .clipShape(Capsule())
            
            if self.recipesVM.networkError != nil {
                Text("There was an error fetching Recipes! Please try again!")
            } else {
                List {
                    ForEach(self.recipesVM.dessertMeals, id: \.self) { meal in
                        Text(meal.strMeal)
                    }
                }
            }
            
            Spacer()
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
