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
        switch cuisinesViewModel.state {
        case .loading:
            loadingView
        case .success(let recipesByCuisine):
            contentView(recipesByCuisine: recipesByCuisine)
        case .failed(let errorMessage):
            emptyView(errorMessage: errorMessage)
        }
    }
    
    func contentView(recipesByCuisine: [String: [Recipe]]) -> some View {
        List {
            Section("Top 10 recipes of the week") {
                CardListView(recipes: cuisinesViewModel.recipesOfTheWeek)
                    .frame(height: 300)
                    .listRowInsets(nil)
                    .padding(.bottom, 24)
            }

            Section("All Cuisines") {
                ForEach(recipesByCuisine.sorted(by: { $0.key < $1.key }), id: \.key) { cuisine, recipes in
                    NavigationLink(value: cuisine) {
                        CuisineCellView(cuisine: cuisine, recipes: recipes)
                    }
                }
            }
        }
        .navigationTitle("Cuisines")
        .navigationDestination(for: String.self) { cuisine in
            RecipesView(cuisine: cuisine, recipes: recipesByCuisine[cuisine] ?? [])
        }
        .refreshable {
            Task {
                await cuisinesViewModel.loadRecipes()
            }
        }
    }
    
    var loadingView: some View {
        ProgressView()
    }
    
    func emptyView(errorMessage: String) -> some View {
        VStack {
            Text("No Recipes Found")
            Text("Swipe to refresh to try Again")
            Text(errorMessage)
            
            Button("Try Again") {
                Task {
                    await cuisinesViewModel.loadRecipes()
                }
            }
        }
    }
}

//#Preview {
//    RecipesView()
//}
