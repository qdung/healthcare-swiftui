import SwiftUI
import Combine

class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isLoading: Bool = false
    @Published var isLoggedIn: Bool = false
    @Published var user: User?
    private var accessToken: String?
    
    func login() {
        guard let url = URL(string: "https://api.example.com/login") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: String] = ["email": email, "password": password]
        request.httpBody = try? JSONEncoder().encode(body)
        
        isLoading = true
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                self.isLoading = false
                
                if let data = data {
                    let decoder = JSONDecoder()
                    if let loginResponse = try? decoder.decode(LoginResponse.self, from: data) {
                        self.user = loginResponse.user
                        self.accessToken = loginResponse.accessToken
                        self.isLoggedIn = true
                    }
                }
            }
        }.resume()
    }
}
