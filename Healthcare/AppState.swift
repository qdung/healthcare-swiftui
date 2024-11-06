import SwiftUI
import Combine

class AppState: ObservableObject {
    @Published var isReadIntroduce: Bool {
        didSet {
            UserDefaults.standard.set(isReadIntroduce, forKey: "isReadIntroduce")
        }
    }

    init() {
        self.isReadIntroduce = UserDefaults.standard.bool(forKey: "isReadIntroduce")
    }
}
