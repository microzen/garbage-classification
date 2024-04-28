import Foundation

class EventViewModel: ObservableObject {
    @Published var eventData: String = ""

    
    func fetchEvent() {
        guard let url = URL(string: "http://127.0.0.1:5000/event") else { return }
        let session = URLSession.shared
        let task = session.dataTask(with: url) { [weak self] data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    self?.eventData = "Client error: \(error.localizedDescription)"
                }
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                DispatchQueue.main.async {
                    self?.eventData = "Server error"
                }
                return
            }
            
            if let data = data, let dataString = String(data: data, encoding: .utf8) {
                DispatchQueue.main.async {
                    self?.eventData = dataString
                }
            }
        }
        task.resume()
    }
}
