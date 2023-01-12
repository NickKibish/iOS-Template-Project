//
//  Quote.swift
//  TemplateApp
//
//  Created by Nick Kibysh on 12/01/2023.
//

import Foundation

public struct Quote: Codable {
    public let id, content, author: String
    public let tags: [String]
    public let authorSlug: String
    public let length: Int
    public let dateAdded: Date
    public let dateModified: Date

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case content, author, tags, authorSlug, length, dateAdded, dateModified
    }
    
    init(id: String, content: String, author: String, tags: [String], authorSlug: String, length: Int, dateAdded: Date, dateModified: Date) {
        self.id = id
        self.content = content
        self.author = author
        self.tags = tags
        self.authorSlug = authorSlug
        self.length = length
        self.dateAdded = dateAdded
        self.dateModified = dateModified
    }
    
    public static let wisestQuote = Quote(id: UUID().uuidString, content: "Next time I’ll deflate all your balls, friend.", author: "Jason Statham", tags: ["wisdom"], authorSlug: "jason-statham", length: 52, dateAdded: Date(), dateModified: Date())
    public static let wisestQuote2 = Quote(id: UUID().uuidString, content: "You don’t need your mouth to pee.", author: "Jason Statham", tags: ["wisdom"], authorSlug: "jason-statham", length: 52, dateAdded: Date(), dateModified: Date())
}
