import SwiftUI
import Combine

struct User:Codable {
    var name: String
    var email: String
    var phone: String
    var gender: String
    var birthday: String
}

struct LoginResponse: Codable {
    var user: User
    var accessToken: String
}

class UserData: ObservableObject {
    @Published var user: User
    
    init(user: User) {
        self.user = user
    }
}
