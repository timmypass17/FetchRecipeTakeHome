//
//  CuisinesViewModel   .swift
//  FetchRecipeTakeHome
//
//  Created by Timmy Nguyen on 4/29/25.
//

import Foundation

@MainActor
class CuisinesViewModel: ObservableObject {
    @Published var recipesByCuisine: [String: [Recipe]] = [:]
    private let recipeService: RecipeServiceProtocol
    
    init(recipeService: RecipeServiceProtocol) {
        self.recipeService = recipeService
        
        Task {
            await loadRecipes()
        }
    }
    
    private func loadRecipes() async {
        do {
            let recipes = try await recipeService.getRecipes()
            for recipe in recipes {
                recipesByCuisine[recipe.cuisine, default: []].append(recipe)
            }
            
            print(Set(recipes.map { $0.cuisine }))
        } catch {
            print("Error loading recipes: \(error)")
        }
    }
    
    
}
