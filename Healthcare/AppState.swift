import SwiftUI
import FirebaseAuth
import Combine

class AppState: ObservableObject {
    @Published var isUserLoggedIn: Bool = false 
    
    @Published var isReadIntroduce: Bool {
        didSet {
            UserDefaults.standard.set(isReadIntroduce, forKey: "isReadIntroduce")
        }
    }
    
    
    init() {
        self.isReadIntroduce = UserDefaults.standard.bool(forKey: "isReadIntroduce")
        Auth.auth().addStateDidChangeListener { auth, user in self.isUserLoggedIn = user != nil }
    }
}
