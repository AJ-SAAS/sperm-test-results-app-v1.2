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
    @State private var isLoggedIn = false
    private let authService = AuthService()

    var body: some View {
        VStack {
            if isLoggedIn {
                Text("Welcome!")
                Button("Logout") {
                    do {
                        try authService.logout()  // Fixed: added '.' and proper try syntax
                        isLoggedIn = false
                        email = ""
                        password = ""
                        print("Logout successful!")
                    } catch {
                        print("Logout failed: \(error.localizedDescription)")
                    }
                }
                .padding()
            } else {
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
                            isLoggedIn = true
                        }
                    }
                }
                .padding()
            }
        }
    }
}

#Preview {
    ContentView()
}
