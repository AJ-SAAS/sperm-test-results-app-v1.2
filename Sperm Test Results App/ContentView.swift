//
//  ContentView.swift
//  Sperm Test Results App
//
//  Created by Work Laptop on 10/04/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var email = ""
    @State private var password = ""
    private let authService = AuthService()

    var body: some View {
        VStack {
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            Button("Login") {
                authService.login(email: email, password: password) { error in
                    if let error = error {
                        print("Login failed: \(error.localizedDescription)")
                    } else {
                        print("Login successful!")
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}

