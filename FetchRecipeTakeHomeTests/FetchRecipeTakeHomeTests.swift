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

    @Test func fetchRecipes() async throws {
        let recipes = try await recipeService.getRecipes(endpoint: .regular)
        
        #expect(recipes.count > 0)
        #expect(recipes.contains { $0.name == "Apam Balik"} )
        #expect(recipes.contains { $0.id == "0c6ca6e7-e32a-4053-b824-1dbf749910d8" })
    }
    
    @Test func fetchRecipesMalformed() async throws {
        await #expect(throws: Error.self) {
            _ = try await recipeService.getRecipes(endpoint: .malformed)
        }
    }
    
    @Test func fetchRecipesEmpty() async throws {
        let recipes = try await recipeService.getRecipes(endpoint: .empty)
        #expect(recipes.isEmpty)
    }
    
    @Test func testRecipeDecoding() throws {
        let recipe = try JSONDecoder().decode(Recipe.self, from: recipeJSON)
        
        #expect(recipe.cuisine == "Malaysian")
        #expect(recipe.name == "Apam Balik")
        #expect(recipe.photoUrlSmall == "https://example.com/apam.jpg")
        #expect(recipe.sourceUrl == "https://example.com/recipe")
        #expect(recipe.id == "0c6ca6e7-e32a-4053-b824-1dbf749910d8")
    }
    
    @Test func testRecipeResponseDecoding() throws {
        let response = try JSONDecoder().decode(RecipesResponse.self, from: recipeResponseJSON)
        
        #expect(response.recipes.count > 0)
    }
}
