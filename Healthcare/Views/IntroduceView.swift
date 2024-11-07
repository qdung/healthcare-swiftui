import SwiftUI

struct IntroduceView: View {
    @State private var step: Int = 0
    @State private var navigateToLogin: Bool = false
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Welcome to the Introduction Screen")
                    .font(.largeTitle)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .center)
                    .multilineTextAlignment(.center)
                
                
                Spacer()
                Button(action: {
                    if step < 3 {
                        step += 1
                    } else {
                        appState.isReadIntroduce = true
                    }
                }) {
                    
                    Text(step == 3 ? "Start your health" : "Next Step")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(step == 3 ? Color.green : Color.blue)
                        .cornerRadius(8)
                }
                .padding()
                NavigationLink(destination: LoginView(), isActive: $navigateToLogin) {
                    EmptyView()
                }
                
            }.frame(maxWidth: .infinity)
        }
    }
}

