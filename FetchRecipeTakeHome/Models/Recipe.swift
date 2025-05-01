//
//  Recipe.swift
//  FetchRecipeTakeHome
//
//  Created by Timmy Nguyen on 4/29/25.
//

import Foundation

struct Recipe: Decodable, Identifiable {
    var id: String
    let cuisine: String
    let name: String
    let photoUrlSmall: String
    let photoUrlLarge: String
    let sourceUrl: String?
    let youtubeUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "uuid"
        case cuisine
        case name
        case photoUrlSmall = "photo_url_small"
        case photoUrlLarge = "photo_url_large"
        case sourceUrl = "source_url"
        case youtubeUrl = "youtube_url"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.cuisine = try container.decode(String.self, forKey: .cuisine)
        self.name = try container.decode(String.self, forKey: .name)
        self.photoUrlSmall = try container.decode(String.self, forKey: .photoUrlSmall)
        self.photoUrlLarge = try container.decode(String.self, forKey: .photoUrlLarge)
        self.sourceUrl = try container.decodeIfPresent(String.self, forKey: .sourceUrl)
        self.youtubeUrl = try container.decodeIfPresent(String.self, forKey: .youtubeUrl)
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
