//
//  RecipesAPIRequest.swift
//  FetchRecipeTakeHome
//
//  Created by Timmy Nguyen on 4/29/25.
//

import Foundation

struct RecipesAPIRequest: APIRequest {
    var urlRequest: URLRequest {
        let urlComponents = URLComponents(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json")!
        let request = URLRequest(url: urlComponents.url!)
        return request
    }

    func decodeResponse(data: Data) throws -> [Recipe] {
        let decoder = JSONDecoder()
        let response = try decoder.decode(RecipesResponse.self, from: data)
        return response.recipes
    }
}
