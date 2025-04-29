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
        NavigationView {
            List {
                ForEach(cuisinesViewModel.recipesByCuisine.sorted(by: { $0.key < $1.key }), id: \.key) { cuisine, recipes in
                    HStack {
                        Text("\(Recipe.flagEmoji(cuisine: cuisine)) \(cuisine)")
                        Spacer()
                        Text("\(recipes.count)")
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .navigationTitle("Cuisines")
        }
    }
}

//#Preview {
//    RecipesView()
//}
