//
//  RecipesViewModel.swift
//  FetchRecipeTakeHome
//
//  Created by Timmy Nguyen on 4/30/25.
//

import Foundation

class RecipesViewModel: ObservableObject {
    @Published var selectedRecipe: Recipe?
    @Published var selectedUrl: URL?
    @Published var isPresentingOptions = false
    let cuisine: String
    let recipes: [Recipe]
    
    init(cuisine: String, recipes: [Recipe]) {
        self.cuisine = cuisine
        self.recipes = recipes
    }
}
