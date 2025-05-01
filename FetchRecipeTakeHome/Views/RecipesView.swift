//
//  RecipesView.swift
//  FetchRecipeTakeHome
//
//  Created by Timmy Nguyen on 4/29/25.
//

import SwiftUI

struct RecipesView: View {
    @StateObject var recipesViewModel: RecipesViewModel

    var body: some View {
        List(Array(recipesViewModel.recipes.enumerated()), id: \.offset) { index, recipe in
            HStack {
                CachedAsyncImageView(url: URL(string: recipe.photoUrlSmall))
                    .frame(width: 50, height: 50)
                    .clipShape(RoundedRectangle(cornerRadius: 4))

                Text("\(index + 1).")
                    .foregroundStyle(.secondary)
                    .padding(.leading, 8)
                
                Text(recipe.name)
                    .lineLimit(1)
                
                Spacer()
                
                Button {
                    recipesViewModel.selectedRecipe = recipe
                    recipesViewModel.isPresentingOptions.toggle()
                } label: {
                    Label("Recipe source", systemImage: "info.circle")
                }
                .labelStyle(.iconOnly)
                .foregroundStyle(.secondary)

            }
        }
        .navigationTitle("\(Recipe.flagEmoji(cuisine: recipesViewModel.cuisine)) \(recipesViewModel.cuisine) Recipes")
        .confirmationDialog("Selected \"\(recipesViewModel.selectedRecipe?.name ?? "recipe")\"",  isPresented: $recipesViewModel.isPresentingOptions, titleVisibility: .visible) {
            Button("View Youtube") {
                if let youtubeUrl = recipesViewModel.selectedRecipe?.youtubeUrl {
                    recipesViewModel.selectedUrl = URL(string: youtubeUrl)
                }
            }
            Button("View Website") {
                if let sourceUrl = recipesViewModel.selectedRecipe?.sourceUrl {
                    recipesViewModel.selectedUrl = URL(string: sourceUrl)
                }
            }
            .disabled(recipesViewModel.selectedRecipe?.sourceUrl == nil)
            Button("Cancel", role: .cancel) {
                
            }
        }
        .sheet(item: $recipesViewModel.selectedUrl) { url in
            SafariView(url: url)
        }
    }
}


extension URL: Identifiable {
    public var id: String {
        self.absoluteString
    }
}

//#Preview {
//    RecipesView()
//}
