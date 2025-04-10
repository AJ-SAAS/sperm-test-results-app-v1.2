import SwiftUI

struct SignUpView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var showError = false
    @State private var errorMessage = ""
    private let authService = AuthService()
    @Binding var isLoggedIn: Bool
    @Binding var showSignUp: Bool

    var body: some View {
        VStack {
            Text("Sign Up")
                .font(.title)
                .padding()
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            Button("Sign Up") {
                authService.signUp(email: email, password: password) { error in
                    if let error = error {
                        errorMessage = error.localizedDescription
                        showError = true
                        print("Sign-up failed: \(errorMessage)")
                    } else {
                        print("Sign-up successful!")
                        authService.login(email: email, password: password) { loginError in
                            if loginError == nil {
                                isLoggedIn = true
                                showSignUp = false  // Dismiss sheet
                            }
                        }
                    }
                }
            }
            .padding()
        }
        .alert(isPresented: $showError) {
            Alert(title: Text("Sign-up Error"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
        }
    }
}

#Preview {
    SignUpView(isLoggedIn: .constant(false), showSignUp: .constant(false))
}
