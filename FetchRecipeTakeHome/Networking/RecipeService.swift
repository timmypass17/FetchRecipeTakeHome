//
//  RecipeService.swift
//  FetchRecipeTakeHome
//
//  Created by Timmy Nguyen on 4/29/25.
//

import Foundation

protocol RecipeServiceProtocol {
    func getRecipes() async throws -> [Recipe]
}

class RecipeService: RecipeServiceProtocol {
    func getRecipes() async throws -> [Recipe] {
        let request = RecipesAPIRequest()
        let recipes = try await sendRequest(request)
        return recipes
    }
}
