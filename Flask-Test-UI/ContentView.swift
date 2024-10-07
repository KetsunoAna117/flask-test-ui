//
//  ContentView.swift
//  Flask-Test-UI
//
//  Created by Hans Arthur Cupiterson on 29/09/24.
//

import SwiftUI
import TipKit

struct ContentView: View {
    @State var vm = ViewModel()
    
    let showTip = PopupTip(
        title: Text("Check me!"),
        message: Text("Use this button to start fetching data"),
        image: (
            Image(systemName: "exclamationmark.triangle.fill")
        )
    )
    
    let displayFetchTip = InViewTip(
        title: Text("Display Fetched Data"),
        message: Text("Press Start Fetching Data Button to start fetching data")
    )
    
    var body: some View {
        VStack {
            TipView(displayFetchTip)
                .tipBackground(.ultraThinMaterial)
            
            List(vm.stockList, id: \.name) { stock in
                HStack {
                    Text(stock.name)
                    Spacer()
                    Text("Rp. \(stock.price.withCommas())")  // Assuming price is part of Stock model
                }
            }
            
            VStack {
                Button("Start Fetching Data") {
                    print("Button Pressed, Start fetching data periodically...")
                    showTip.invalidate(reason: .actionPerformed)
                    vm.setupWebSocket()
                }
                .buttonStyle(BorderedProminentButtonStyle())
                .popoverTip(showTip)
                
                Button("Stop Fetching Data", role: .destructive) {
                    print("Button Pressed, Stop fetching data...")
                    vm.disconnectWebSocket()
                    vm.stockList = []
                }
                .buttonStyle(BorderedProminentButtonStyle())
                
                Button("Send Hello World") {
                    print("Sending Hello World")
                    vm.handleUserInput()
                    
                    Task {
                        await InViewTip.eventTriggeredEvent.donate()
                    }
                }
                .buttonStyle(BorderedButtonStyle())
            }
            .frame(maxWidth: .infinity)
        }
        .padding()
    }
}

#Preview {
    ContentView()
        .task {
            try? Tips.resetDatastore()
            try? Tips.configure([
                .displayFrequency(.immediate),
                .datastoreLocation(.applicationDefault)
            ])
        }
}

extension Int {
    func withCommas() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value:self))!
    }
}

