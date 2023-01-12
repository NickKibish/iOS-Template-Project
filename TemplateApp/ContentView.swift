//
//  ContentView.swift
//  TemplateApp
//
//  Created by Nick Kibysh on 12/01/2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        VStack {
            Spacer()
            Text(viewModel.quote.content)
                .font(.title)
                .padding()
                .accessibilityIdentifier("quote_content")
            HStack {
                Spacer()
                Text("- " + viewModel.quote.author)
            }
            .padding()
            Spacer()
            Button("Make Me Wise") {
                Task {
                    await viewModel.loadQuote()
                }
            }
            .accessibilityIdentifier("wise_button")
        }
        .padding()
        .onAppear {
            Task {
                await viewModel.loadQuote()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(
            viewModel: ContentView.ViewModel(
                quoter: Quoter(request: MockRequest())
            )
        )
    }
}
