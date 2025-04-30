//
//  RecipesView.swift
//  FetchRecipeTakeHome
//
//  Created by Timmy Nguyen on 4/29/25.
//

import SwiftUI

struct CuisinesView: View {
    @StateObject var cuisinesViewModel: CuisinesViewModel

    var body: some View {
        List {
            ForEach(cuisinesViewModel.recipesByCuisine.sorted(by: { $0.key < $1.key }), id: \.key) { cuisine, recipes in
                NavigationLink(value: cuisine) {
                    HStack {
                        Text("\(Recipe.flagEmoji(cuisine: cuisine)) \(cuisine)")
                        Spacer()
                        Text("\(recipes.count)")
                            .foregroundStyle(.secondary)
                    }
                }
            }
        }
        .navigationTitle("Cuisines")
        .navigationDestination(for: String.self) { cuisine in
            RecipesView(cuisine: cuisine, recipes: cuisinesViewModel.recipesByCuisine[cuisine] ?? [])
        }
        .refreshable {
            Task {
                await cuisinesViewModel.loadRecipes()
            }
        }
    }
}

//#Preview {
//    RecipesView()
//}
