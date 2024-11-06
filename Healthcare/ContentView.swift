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
    NavigationView {
      if appState.isReadIntroduce {
        LoginView()
          .environmentObject(appState)
      } else {
        IntroduceView()
          .environmentObject(appState)
      }
    }
  }
}

#Preview {
  ContentView()
}
