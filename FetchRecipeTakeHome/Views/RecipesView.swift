//
//  RecipesView.swift
//  FetchRecipeTakeHome
//
//  Created by Timmy Nguyen on 4/29/25.
//

import SwiftUI

struct RecipesView: View {
    @State var isPresentingOptions = false
    @State var selectedRecipe: Recipe?
    @State var selectedUrl: URL?
    let cuisine: String
    let recipes: [Recipe]
    
    var body: some View {
        List(Array(recipes.enumerated()), id: \.offset) { index, recipe in
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
                    selectedRecipe = recipe
                    isPresentingOptions.toggle()
                } label: {
                    Label("Recipe source", systemImage: "info.circle")
                }
                .labelStyle(.iconOnly)
                .foregroundStyle(.secondary)

            }
        }
        .navigationTitle("\(Recipe.flagEmoji(cuisine: cuisine)) \(cuisine) Recipes")
        .confirmationDialog("Selected \"\(selectedRecipe?.name ?? "recipe")\"",  isPresented: $isPresentingOptions, titleVisibility: .visible) {
            Button("View Youtube") {
                if let youtubeUrl = selectedRecipe?.youtubeUrl {
                    selectedUrl = URL(string: youtubeUrl)
                }
            }
            Button("View Website") {
                if let sourceUrl = selectedRecipe?.sourceUrl {
                    selectedUrl = URL(string: sourceUrl)
                }
            }
            .disabled(selectedRecipe?.sourceUrl == nil)
            Button("Cancel", role: .cancel) {
                
            }
        }
        .sheet(item: $selectedUrl) { url in
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
