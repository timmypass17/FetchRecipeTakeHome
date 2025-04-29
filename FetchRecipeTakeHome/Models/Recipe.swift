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
    var id: String
//    let youtube_url: String
    
    enum CodingKeys: String, CodingKey {
        case cuisine
        case name
        case photoUrlSmall = "photo_url_small"
        case sourceUrl = "source_url"
        case id = "uuid"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.cuisine = try container.decode(String.self, forKey: .cuisine)
        self.name = try container.decode(String.self, forKey: .name)
        self.photoUrlSmall = try container.decode(String.self, forKey: .photoUrlSmall)
        self.sourceUrl = try container.decodeIfPresent(String.self, forKey: .sourceUrl)
        self.id = try container.decode(String.self, forKey: .id)
    }
    
    static private let flagEmojis: [String: String] = [
        "Croatian": "🇭🇷",
        "Portuguese": "🇵🇹",
        "Canadian": "🇨🇦",
        "Polish": "🇵🇱",
        "French": "🇫🇷",
        "Malaysian": "🇲🇾",
        "British": "🇬🇧",
        "Greek": "🇬🇷",
        "Russian": "🇷🇺",
        "American": "🇺🇸",
        "Italian": "🇮🇹",
        "Tunisian": "🇹🇳"
    ]

    static func flagEmoji(cuisine: String) -> String {
        return Recipe.flagEmojis[cuisine] ?? "🍽️"
    }
}
