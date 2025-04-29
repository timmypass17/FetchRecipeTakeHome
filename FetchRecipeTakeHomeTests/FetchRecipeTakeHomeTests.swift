//
//  FetchRecipeTakeHomeTests.swift
//  FetchRecipeTakeHomeTests
//
//  Created by Timmy Nguyen on 4/29/25.
//

import Testing
@testable import FetchRecipeTakeHome
import Foundation

struct FetchRecipeTakeHomeTests {
    
    let recipeService: RecipeServiceProtocol = RecipeService()

    @Test func fetchRestaurants() async throws {
        let recipes = try await recipeService.getRecipes()
        
        #expect(recipes.count > 0)
        #expect(recipes.contains { $0.name == "Apam Balik"} )
        #expect(recipes.contains { $0.uuid == "0c6ca6e7-e32a-4053-b824-1dbf749910d8" })
    }
    
    @Test func testRecipeDecoding() throws {
        let recipe = try JSONDecoder().decode(Recipe.self, from: recipeJSON)
        
        #expect(recipe.cuisine == "Malaysian")
        #expect(recipe.name == "Apam Balik")
        #expect(recipe.photoUrlSmall == "https://example.com/apam.jpg")
        #expect(recipe.sourceUrl == "https://example.com/recipe")
        #expect(recipe.uuid == "0c6ca6e7-e32a-4053-b824-1dbf749910d8")
    }
    
    @Test func testRecipeResponseDecoding() throws {
        let response = try JSONDecoder().decode(RecipesResponse.self, from: recipeResponseJSON)
        
        #expect(response.recipes.count > 0)
    }
}
