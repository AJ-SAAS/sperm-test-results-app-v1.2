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
    @State private var showError = false
    @State private var errorMessage = ""
    @State private var showSignUp = false

    var body: some View {
        NavigationView {
            VStack {
                if isLoggedIn {
                    Text("Welcome!")
                    Button("Logout") {
                        do {
                            try AuthService().logout()
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
                        AuthService().login(email: email, password: password) { error in
                            if let error = error {
                                errorMessage = error.localizedDescription
                                showError = true
                                print("Login failed: \(errorMessage)")
                            } else {
                                print("Login successful!")
                                isLoggedIn = true
                            }
                        }
                    }
                    .padding()
                    Button("Sign Up") {
                        showSignUp = true
                    }
                    .padding()
                }
            }
            .navigationTitle("Login")
            .alert(isPresented: $showError) {
                Alert(title: Text("Login Error"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
            }
            .sheet(isPresented: $showSignUp) {
                SignUpView(isLoggedIn: $isLoggedIn, showSignUp: $showSignUp)
            }
        }
    }
}

#Preview {
    ContentView()
}
