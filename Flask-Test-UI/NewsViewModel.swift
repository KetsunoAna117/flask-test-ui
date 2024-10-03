import Foundation
import SocketIO

@Observable
class NewsViewModel {
    var newsList: [News] = []
    var randomNews: News?
    
    let manager: SocketManager
    let socket: SocketIOClient
    
    let url_rest_railway_news = "http://flask-test-production-a93a.up.railway.app/random_news"
    let url_rest_local_news = "http://127.0.0.1:5001/random_news"
    let ws_url_local = "ws://127.0.0.1:5001"
    
    init() {
        // Initialize the Socket.IO manager
        manager = SocketManager(
            socketURL: URL(string: ws_url_local)!,
            config: [.log(true), .compress]
        )
        socket = manager.defaultSocket
        setupWebSocket()
    }
    
    // Setup WebSocket event listeners for news
    func setupWebSocket() {
        // Handle the connection event
        socket.on(clientEvent: .connect) { data, ack in
            print("WebSocket connected for News")
        }
        
        // Listen for a 'random_news' event from the server
        socket.on("random_news") { [weak self] data, ack in
            print("Random News Event Triggered")
            guard let self = self else { return }
            if let newsData = data[0] as? [String: Any] {
                // Parse the random news data and update
                self.handleNewsUpdate(newsData)
            }
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
    
    // Parse and update the random news data
    private func handleNewsUpdate(_ newsData: [String: Any]) {
        do {
            // Convert the news data dictionary into a JSON format and decode it
            let jsonData = try JSONSerialization.data(withJSONObject: newsData)
            let updatedNews = try JSONDecoder().decode(News.self, from: jsonData)
            
            // Update randomNews on the main thread
            DispatchQueue.main.async {
                print("Random News Updated")
                self.randomNews = updatedNews
            }
        } catch {
            print("Error decoding news data: \(error)")
        }
    }
    
    // Fetch random news with an HTTP GET request
    func fetchRandomNews() {
        let url = URL(string: url_rest_local_news)!
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error fetching random news: \(String(describing: error))")
                return
            }
            
            do {
                // Decode the JSON response into the News object
                let newsItem = try JSONDecoder().decode(News.self, from: data)
                DispatchQueue.main.async {
                    self.randomNews = newsItem
                    print("Random News fetched and updated")
                }
            } catch {
                print("Error decoding news data: \(error)")
            }
        }
        
        task.resume()  // Start the HTTP GET request
    }
    
    // Disconnect WebSocket
    func disconnectWebSocket() {
        socket.off("random_news")
        socket.off(clientEvent: .connect)
        socket.disconnect()
    }
}
