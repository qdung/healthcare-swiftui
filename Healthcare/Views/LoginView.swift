import FirebaseAuth
import FirebaseCore
import GoogleSignIn
import SwiftUI

func getRootViewController() -> UIViewController {
    guard let window = UIApplication.shared.windows.first else {
        fatalError("Invalid Configuration")
    }
    return window.rootViewController!
    
}

struct LoginView: View {
    @State private var email: String = "qdung1994@gmail.com"
    @State private var password: String = ""
    @State private var isPasswordVisible: Bool = false
    @State private var isLoading = false
    
    func loginWithEmail() {
        isLoading = true
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            isLoading = false
            if let error = error {
                print("Error logging in: \(error.localizedDescription)")
            } else {
                print("Successfully logged in with email")
            }
        }
    }

    func loginWithGoogle() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config

        GIDSignIn.sharedInstance.signIn(withPresenting: getRootViewController()) { result, error in
            guard error == nil else {
                return
            }

            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString
            else {
                return
            }

            let credential = GoogleAuthProvider.credential(
                withIDToken: idToken,
                accessToken: user.accessToken.tokenString)

            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    print("Error logging in with Google: \(error.localizedDescription)")
                } else {
                    print("Successfully logged in with Google")
                }
            }
        }

    }
    
    var body: some View {
        VStack {
            // Header
            VStack {
                GeometryReader { proxy in
                    HStack {
                        Spacer()
                    }
                    .padding(.top, proxy.safeAreaInsets.top)
                    .padding(.horizontal)
                    .background(Color.white)
                }
                
                Spacer()
                
                Image(systemName: "lock.shield")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.purple)
                
                Text("Health Assistant!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 20)
                    .multilineTextAlignment(.center)
                
                Text("Keep your health good!")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.bottom, 40)
            }
            .frame(height: UIScreen.main.bounds.height * 2 / 5)
            .background(Color.white)
            .edgesIgnoringSafeArea(.top)
            
            // Login Form
            VStack {
                TextField("Email", text: $email)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 10)
                
                HStack {
                    if isPasswordVisible {
                        TextField("Password", text: $password)
                    } else {
                        SecureField("Password", text: $password)
                    }
                    Button(action: {
                        isPasswordVisible.toggle()
                    }) {
                        Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                            .foregroundColor(.gray)
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
                
                Button(action: {
                    loginWithEmail()
                }) {
                    Text("Login")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .cornerRadius(10)
                        .padding(.horizontal, 20)
                }
                
                Button(action: {
                    // Handle login action
                }) {
                    
                    Text("Login with Google")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .padding(.horizontal, 20)
                }
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                
                Button(action: {
                    // Handle forgot password action
                }) {
                    Text("Forgot password?")
                        .foregroundColor(.green)
                        .padding(.top, 10)
                        .fontWeight(.medium)
                }
                
                Spacer()
                HStack {
                    Text("Don’t have an account?")
                    Button(action: {
                        // Handle register action
                    }) {
                        Text("Register!")
                            .foregroundColor(.green)
                            .fontWeight(.medium)
                    }
                }
                .padding(.bottom, 20)
            }
        }
    }
}
