//
//  QuoterTests.swift
//  TemplateAppTests
//
//  Created by Nick Kibysh on 17/01/2023.
//

import XCTest
@testable import TemplateApp

final class QuoterTests: XCTestCase {
    func testQuoter() async {
        let quoter = Quoter(request: MockRequest())
        
        let mock1 = Quote.wisestQuote
        let mock2 = Quote.wisestQuote2
        
        let q1 = await quoter.randomQuote()
        let q2 = await quoter.randomQuote()
        
        XCTAssertEqual(q1?.content, mock1.content)
        XCTAssertEqual(q2?.content, mock2.content)
        
        XCTAssertEqual(q1?.author, mock1.author)
        XCTAssertEqual(q2?.authorSlug, mock2.authorSlug)
    }
}
