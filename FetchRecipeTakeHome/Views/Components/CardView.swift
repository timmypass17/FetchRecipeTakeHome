//
//  CardView.swift
//  FetchRecipeTakeHome
//
//  Created by Timmy Nguyen on 4/30/25.
//

import SwiftUI

struct CardView: View {
    let recipe: Recipe
    let index: Int
    
    var medalEmoji: String {
        if index == 0 {
            return "🥇"
        } else if index == 1 {
            return "🥈"
        } else if index == 2 {
            return "🥉"
        } else {
            return "✨"
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            AsyncImage(url: URL(string: recipe.photoUrlLarge)) { image in
                image
                    .resizable()
                    .scaledToFill()

            } placeholder: {
                Color.secondary
            }
            .frame(width: 300, height: 200)
            .clipShape(.rect(topLeadingRadius: 15, topTrailingRadius: 15))
            
            VStack(alignment: .leading) {
                HStack {
                    Text("\(index + 1). \(recipe.name)")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .lineLimit(1)
                
                    Spacer()
                    
                    Text(medalEmoji)
                        .font(.title3)
                }
                
                Text("\(Recipe.flagEmoji(cuisine: recipe.cuisine)) \(recipe.cuisine)")
                    .foregroundStyle(.secondary)
            }
            .padding(12)
            
            Spacer()
            
        }
        .frame(width: 300, height: 300)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(.bar)
        )
    }
}


//#Preview {
//    CardView()
//}
