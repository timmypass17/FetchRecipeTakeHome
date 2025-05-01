//
//  RecipeService.swift
//  FetchRecipeTakeHome
//
//  Created by Timmy Nguyen on 4/29/25.
//

import Foundation

protocol RecipeServiceProtocol {
    func getRecipes(endpoint: RecipesAPIRequest.Endpoint) async throws -> [Recipe]
}

class RecipeService: RecipeServiceProtocol {
    func getRecipes(endpoint: RecipesAPIRequest.Endpoint = .regular) async throws -> [Recipe] {
        let request = RecipesAPIRequest(endpoint: endpoint)
        let recipes = try await sendRequest(request)
        return recipes
    }
}
