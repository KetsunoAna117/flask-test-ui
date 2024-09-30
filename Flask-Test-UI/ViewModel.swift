import Foundation

@Observable
class ViewModel {
    var stockList: [Stock] = []
    var timer: Timer? = nil
    
    let url_railway = "http://flask-test-production-a93a.up.railway.app"
    let url_local = "http://127.0.0.1:5000"
    
    func startFetchingPeriodically() {
        // Call fetchData once immediately
        fetchData()

        // Invalidate any previous timer
        timer?.invalidate()

        // Start a timer that repeats every 60 seconds
        timer = Timer.scheduledTimer(withTimeInterval: 10, repeats: true) { [weak self] _ in
            print("Now fetching data...")
            self?.fetchData()
        }
    }
    
    func stopFetching() {
        timer?.invalidate()
        timer = nil
    }

    func fetchData(completion: @escaping (Error?) -> Void = { _ in }) {
        let url = URL(string: "\(url_railway)/stock")!
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let error = error {
                // Handle the error
                DispatchQueue.main.async {
                    print("Failed to fetch data with error: \(error)")
                    completion(error)
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(NSError(domain: "DataError", code: -1, userInfo: nil))
                }
                return
            }
            
            do {
                let stocks = try JSONDecoder().decode([Stock].self, from: data)
                
                // Update the stock list on the main thread
                DispatchQueue.main.async {
                    self?.stockList = stocks
                    completion(nil) // No error, return success
                }
                
            } catch {
                // Handle decoding error
                DispatchQueue.main.async {
                    print("Failed to fetch data with error: \(error)")
                    completion(error)
                }
            }
        }
        
        task.resume()  // Start the task
    }
}
