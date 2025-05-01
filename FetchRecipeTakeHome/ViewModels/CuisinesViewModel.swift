//
//  CuisinesViewModel   .swift
//  FetchRecipeTakeHome
//
//  Created by Timmy Nguyen on 4/29/25.
//

import Foundation

@MainActor
class CuisinesViewModel: ObservableObject {
    @Published var state: State = .loading
    
    var recipesOfTheWeek: [Recipe] {
        guard case let .success(recipesByCuisine) = state else { return [] }
        var recipesOfTheWeek: [Recipe] = []
        var allRecipes = recipesByCuisine.values.flatMap { $0 }

        while recipesOfTheWeek.count < 10 && !allRecipes.isEmpty {
            let randomIndex = Int.random(in: 0..<allRecipes.count)
            let randomRecipe = allRecipes.remove(at: randomIndex)
            recipesOfTheWeek.append(randomRecipe)
        }
        return recipesOfTheWeek
    }
    
    enum State {
        case loading, success([String: [Recipe]]), failed(String)
    }
    
    private let recipeService: RecipeServiceProtocol
    
    init(recipeService: RecipeServiceProtocol) {
        self.recipeService = recipeService
        
        Task {
            await loadRecipes()
        }
    }
    
     func loadRecipes() async {
        do {
            state = .loading
            let recipes = try await recipeService.getRecipes(endpoint: .regular)
            var recipesByCuisine: [String: [Recipe]] = [:]
            for recipe in recipes {
                recipesByCuisine[recipe.cuisine, default: []].append(recipe)
            }
            
            guard !recipesByCuisine.isEmpty else {
                state = .failed("No Recipes Found")
                return
            }
            
            state = .success(recipesByCuisine)
        } catch {
            state = .failed(error.localizedDescription)
        }
    }
}
