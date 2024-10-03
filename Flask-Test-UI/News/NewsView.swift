//
//  NewsView.swift
//  Flask-Test-UI
//
//  Created by Bryan Vernanda on 02/10/24.
//

import SwiftUI

struct NewsView: View {
    @State var newsVM = NewsViewModel()  // Use the NewsViewModel instead of ViewModel
    
    var body: some View {
        VStack {
            // Display a list of news items if any
            if let randomNews = newsVM.randomNews {
                VStack {
                    Text("Random News")
                        .font(.headline)
                        .padding(.bottom, 5)
                    
                    Text(randomNews.description)
                        .font(.body)
                    
                    Text("Value Fluctuation: \(randomNews.valueFluctuation)")
                        .font(.subheadline)
                        .padding(.top, 2)
                }
                .padding()
            } else {
                Text("No random news available.")
            }
            
            Button("Fetch Random News") {
                print("Button Pressed, Fetching random news from the server...")
                newsVM.fetchRandomNews()  // Fetch the random news via HTTP
            }
            .buttonStyle(BorderedProminentButtonStyle())
            
            Button("Start Listening to WebSocket") {
                print("Button Pressed, Start listening for WebSocket news...")
                newsVM.setupWebSocket()  // Setup the WebSocket connection for news
            }
            .buttonStyle(BorderedProminentButtonStyle())
            
            Button("Stop Listening to WebSocket") {
                print("Button Pressed, Stop listening to WebSocket...")
                newsVM.disconnectWebSocket()  // Disconnect from WebSocket
            }
            .buttonStyle(BorderedProminentButtonStyle())
            .tint(Color.red)
        }
        .padding()
    }
}

#Preview {
    NewsView()
}
