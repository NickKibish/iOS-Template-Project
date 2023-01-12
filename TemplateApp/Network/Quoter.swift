//
//  RequestManager.swift
//  TemplateApp
//
//  Created by Nick Kibysh on 12/01/2023.
//

import Foundation

protocol Request {
    func quoteRequest(tagParag: String?) async throws -> Data?
}

class QuoteRequest: Request {
    let url: String
    
    fileprivate init(url: String) {
        self.url = url
    }
    
    func quoteRequest(tagParag: String?) async throws -> Data? {
        let baseUrl = url + "/random"
        let urlString = tagParag.map { baseUrl + $0 } ?? baseUrl
        let url = URL(string: urlString)!
        let request = URLRequest(url: url)
        
        return await withCheckedContinuation { continuation in
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                continuation.resume(with: .success(data))
            }
            
            task.resume()
        }
    }
}

class ProdRequest: QuoteRequest {
    init() {
        super.init(url: "https://api.quotable.io")
    }
}

class StagingRequest: QuoteRequest {
    init() {
        super.init(url: "https://staging.quotable.io")
    }
}

private struct JasonQuotes: Sequence {
    struct QuoteIterator: IteratorProtocol {
        let quotes: JasonQuotes
        private var currentIndex = 0
        
        init(quotes: JasonQuotes) {
            self.quotes = quotes
        }
        
        mutating func next() -> Quote? {
            if currentIndex >= quotes.quotes.count {
                currentIndex = 0
            }
            
            let element = quotes.quotes[currentIndex]
            currentIndex += 1
            return element
        }
    }
    
    let quotes: [Quote] = [.wisestQuote, .wisestQuote2]
    
    func makeIterator() -> some IteratorProtocol {
        return QuoteIterator(quotes: self)
    }
}


class MockRequest: Request {
    private let quotes = JasonQuotes()
    private lazy var iterator = quotes.makeIterator() as! JasonQuotes.QuoteIterator
    
    func quoteRequest(tagParag: String?) async throws -> Data? {
        guard let quote = iterator.next() else { return nil }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .formatted(dateFormatter)
        
        return try? encoder.encode(quote)
    }
}

public class Quoter {
    let request: Request
    
    public init() {
        self.request = ProdRequest()
    }
    
    init(request: Request) {
        self.request = request
    }
    
    public func randomQuote(tags: [String]? = nil) async -> Quote? {
        let data: Data?
        do {
            let tagString = tags.map { $0.joined(separator: "-") }
            data = try await request.quoteRequest(tagParag: tagString)
        } catch {
            return nil
        }
        
        guard let data else {
            return nil
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        
        do {
            let quote = try decoder.decode(Quote.self, from: data)
            return quote
        } catch {
            print(error)
            return nil
        }
    }
}
