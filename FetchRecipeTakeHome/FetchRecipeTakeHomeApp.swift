//
//  FetchRecipeTakeHomeApp.swift
//  FetchRecipeTakeHome
//
//  Created by Timmy Nguyen on 4/29/25.
//

import SwiftUI

@main
struct FetchRecipeTakeHomeApp: App {
    let recipeService = RecipeService()

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                CuisinesView(cuisinesViewModel: CuisinesViewModel(recipeService: recipeService))
            }
        }
    }
}
