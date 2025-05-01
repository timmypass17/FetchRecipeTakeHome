//
//  CuisineCellView.swift
//  FetchRecipeTakeHome
//
//  Created by Timmy Nguyen on 4/30/25.
//

import SwiftUI

struct CuisineCellView: View {
    let cuisine: String
    let recipes: [Recipe]
    
    var body: some View {
        HStack {
            Text("\(Recipe.flagEmoji(cuisine: cuisine)) \(cuisine)")
            Spacer()
            Text("\(recipes.count)")
                .foregroundStyle(.secondary)
        }
    }
}

//#Preview {
//    CuisineCellView()
//}
