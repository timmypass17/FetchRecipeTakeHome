//
//  Recipe.swift
//  FetchRecipeTakeHome
//
//  Created by Timmy Nguyen on 4/29/25.
//

import Foundation

struct Recipe: Decodable {
    let cuisine: String
    let name: String
    let photoUrlSmall: String
    let sourceUrl: String?
    let uuid: String
//    let youtube_url: String
    
    enum CodingKeys: String, CodingKey {
        case cuisine
        case name
        case photoUrlSmall = "photo_url_small"
        case sourceUrl = "source_url"
        case uuid = "uuid"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.cuisine = try container.decode(String.self, forKey: .cuisine)
        self.name = try container.decode(String.self, forKey: .name)
        self.photoUrlSmall = try container.decode(String.self, forKey: .photoUrlSmall)
        self.sourceUrl = try container.decodeIfPresent(String.self, forKey: .sourceUrl)
        self.uuid = try container.decode(String.self, forKey: .uuid)
    }
}
