//
//  ContentView.swift
//  Healthcare
//
//  Created by Joseph Dung on 5/11/24.
//

import Lottie
import SwiftUI

struct ContentView: View {
    @StateObject private var appState = AppState()
    
    var body: some View {
        HomeView()

//        Group {
//            if appState.isUserLoggedIn {
//                HomeView()
//            } else {
//                if appState.isReadIntroduce {
//                    LoginView()
//                } else {
//                    IntroduceView()
//                }
//                
//            }
//        }
    }
}
#Preview {
    ContentView()
}
