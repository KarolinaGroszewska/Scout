//
//  ContentView.swift
//  Scout
//
//  Created by Kari Groszewska on 2/10/25.
//

import SwiftUI

struct AuthView: View {
    @State private var isLoginMode = true
    @State private var email = ""
    @State private var password = ""
    @State private var hasCompletedOnboarding = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Picker("Mode", selection: $isLoginMode) {
                    Text("Login").tag(true)
                    Text("Sign Up").tag(false)
                }
                .pickerStyle(.segmented)
                .padding()
                
                TextField("Email", text: $email)
                    .textFieldStyle(.roundedBorder)                
                SecureField("Password", text: $password)
                    .textFieldStyle(.roundedBorder)
                
                NavigationLink(destination: OnboardingView(hasCompletedOnboarding: $hasCompletedOnboarding)) {
                    Text(isLoginMode ? "Login" : "Sign Up")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
            }
            .padding()
        }
    }
}

#Preview {
    AuthView()
}
