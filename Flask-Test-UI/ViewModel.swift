//
//  Person.swift
//  Flask-Test-UI
//
//  Created by Hans Arthur Cupiterson on 29/09/24.
//

import Foundation
import SocketIO

@Observable
class ViewModel {
    var stockList: [Stock] = []
    
    let manager: SocketManager
    let socket: SocketIOClient
    
    let url_rest_railway = "http://flask-test-production-a93a.up.railway.app/stock"
    let url_rest_local = "http://127.0.0.1:5001/stock"
    let ws_url_local = "ws://127.0.0.1:5001"
    
    var isConnectedToWebSocket = false
    
    init() {
        // Initialize the Socket.IO manager
        manager = SocketManager(
            socketURL: URL(string: ws_url_local)!,
            config: [.log(true), .compress]
        )
        socket = manager.defaultSocket
    }
    
    // Setup WebSocket event listeners
    func setupWebSocket() {
        if isConnectedToWebSocket == true {
            print("ERROR! Websocket is already connected")
            return
        }
        
        isConnectedToWebSocket = true
        
        // Handle the connection event
        socket.on(clientEvent: .connect) { data, ack in
            print("WebSocket connected")
            
            self.fetchInitialStockList()
        }
        
        // Listen for the 'update_stock' event from the server
        socket.on("update_stock") { [weak self] data, ack in
            print("Update Stock trigerred")
            guard let self = self else { return }
            if let stockData = data[0] as? [[String: Any]] {
                // Parse the stock data and update stockList
                self.handleStockUpdate(stockData)
            }
        }
        
        socket.on("new_stock_event") { data, ack in
            print("New Stock Event Triggered!")
        }
        
        socket.on("user_input_response") { data, ack in
            guard let response = data[0] as? String else { return }
            print("Received Response: \(response)")
        }
        
        // Connect to the WebSocket
        socket.connect()
        
        switch socket.status {
        case .connected:
            print("socket connected")
        case .connecting:
            print("socket connecting")
        case .disconnected:
            print("socket disconnected")
        case .notConnected:
            print("socket not connected")
        }
    }
    
    // Parse and update stock data
    private func handleStockUpdate(_ stockData: [[String: Any]]) {
        do {
            // Convert the stock data dictionary into a JSON format and decode it
            let jsonData = try JSONSerialization.data(withJSONObject: stockData)
            let updatedStocks = try JSONDecoder().decode([Stock].self, from: jsonData)
            
            // Update stockList on the main thread
            DispatchQueue.main.async {
                print("Stock Updated")
                self.stockList = updatedStocks
            }
        } catch {
            print("Error decoding stock data: \(error)")
        }
    }
    
    func handleUserInput(){
        socket.emit("user_input", "User Input: Hello World")
    }
    
    // Make an HTTP GET request to fetch the initial stock list
    func fetchInitialStockList() {
        let url = URL(string: url_rest_local)!
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error fetching stock list: \(String(describing: error))")
                return
            }
            
            do {
                // Decode the JSON response into the Stock array
                let stockList = try JSONDecoder().decode([Stock].self, from: data)
                DispatchQueue.main.async {
                    self.stockList = stockList
                    print("Initial Stock List fetched and updated")
                }
            } catch {
                print("Error decoding stock data: \(error)")
            }
        }
        
        task.resume()  // Start the HTTP GET request
    }
    
    // Disconnect WebSocket
    func disconnectWebSocket() {
        if isConnectedToWebSocket == false {
            print("ERROR! Websocket is not connected")
            return
        }
        
        isConnectedToWebSocket = false
        
        socket.off("update_stock")
        socket.off("new_stock_event")
        socket.off(clientEvent: .connect)
        socket.disconnect()
    }
}

