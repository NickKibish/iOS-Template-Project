//
//  ViewModel.swift
//  TemplateApp
//
//  Created by Nick Kibysh on 12/01/2023.
//

import Foundation
import SwiftUI

extension ContentView {
    @MainActor
    class ViewModel: ObservableObject {
        
        init(quoter: Quoter = Quoter()) {
            #if TEST
                self.quoter = Quoter(request: MockRequest())
            #else
                self.quoter = quoter
            #endif
        }
        
        private let quoter: Quoter
        
        @Published var quote: Quote = Quote.wisestQuote
        
        func loadQuote() async {
            await quoter.randomQuote().map { self.quote = $0 }
        }
    }
}
