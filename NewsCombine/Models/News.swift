//
//  News.swift
//  NewsCombine
//
//  Created by kz on 16/03/2023.
//

import Foundation

struct NewsResponse: Codable {
    let articles: [News]
}

struct News: Codable, Identifiable {
    let id: UUID
    let author: String?
    let url: String
    let source: String
    let title: String
    let description: String?
    let image: String?
    let date: String
    
    init(from decoder: Decoder) throws {
        id = UUID()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        author = try container.decodeIfPresent(String.self, forKey: .author)
        url = try container.decode(String.self, forKey: .url)
        source = try container.decode(String.self, forKey: .source)
        title = try container.decode(String.self, forKey: .title)
        description = try container.decodeIfPresent(String.self, forKey: .description)
        image = try container.decodeIfPresent(String.self, forKey: .image)
        date = try container.decode(String.self, forKey: .date)
    }
}






