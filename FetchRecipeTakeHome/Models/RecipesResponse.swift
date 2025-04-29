//
//  RecipesResponse.swift
//  FetchRecipeTakeHome
//
//  Created by Timmy Nguyen on 4/29/25.
//

import Foundation

struct RecipesResponse: Decodable {
    let recipes: [Recipe]
}
