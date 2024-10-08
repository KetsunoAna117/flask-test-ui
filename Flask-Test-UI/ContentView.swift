//
//  ContentView.swift
//  Flask-Test-UI
//
//  Created by Hans Arthur Cupiterson on 29/09/24.
//

import SwiftUI

struct ContentView: View {
    @State var vm = ViewModel()
    
    var body: some View {
        VStack {
            List(vm.stockList, id: \.name) { stock in
                HStack {
                    Text(stock.name)
                    Spacer()
                    Text(stock.price.description)  // Assuming price is part of Stock model
                }
            }
            Button("Start Fetching Data") {
                print("Button Pressed, Start fetching data periodically...")
                vm.setupWebSocket()
            }
            .buttonStyle(BorderedProminentButtonStyle())
            
            Button("Stop Fetching Data") {
                print("Button Pressed, Stop fetching data...")
                vm.disconnectWebSocket()
                vm.stockList = []
            }
            .buttonStyle(BorderedProminentButtonStyle())
            .tint(Color.red)
            
            Button("Send Hello World") {
                print("Sending Hello World")
                vm.handleUserInput()
            }
            .buttonStyle(BorderedButtonStyle())
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

