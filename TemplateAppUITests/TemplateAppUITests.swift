//
//  TemplateAppUITests.swift
//  TemplateAppUITests
//
//  Created by Nick Kibysh on 12/01/2023.
//

import XCTest

final class TemplateAppUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        app = XCUIApplication()
        setupSnapshot(app!)
        app.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() throws {
        let quoteContent = app.staticTexts["quote_content"]
        XCTAssertTrue(quoteContent.waitForExistence(timeout: 1))
        
        snapshot("0Launch")
        
        let button = app.buttons["wise_button"]
        XCTAssertTrue(button.waitForExistence(timeout: 1))
        button.tap()
        
        snapshot("1NextQuote")
    }
}
