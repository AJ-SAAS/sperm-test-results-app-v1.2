import SwiftUI

struct ContentView: View {
    @StateObject private var testStore = TestStore()
    @State private var isLoggedIn = UserDefaults.standard.string(forKey: "userEmail") != nil
    @State private var showSignUp = false
    @State private var showInput = false

    var body: some View {
        NavigationStack {
            if isLoggedIn {
                List {
                    ForEach(testStore.tests) { test in
                        NavigationLink(destination: ResultsView(test: test)) {
                            Text("Test on \(test.date, format: .dateTime.day().month().year())")
                        }
                    }
                    .onDelete { indices in
                        testStore.tests.remove(atOffsets: indices)
                    }
                }
                .navigationTitle("Sperm Test Results")
                .toolbar {
                    ToolbarItem(placement: .primaryAction) {
                        Button("Add Test") {
                            showInput = true
                        }
                    }
                    ToolbarItem(placement: .secondaryAction) {
                        Button("Logout") {
                            UserDefaults.standard.removeObject(forKey: "userEmail")
                            isLoggedIn = false
                            testStore.tests.removeAll()
                        }
                    }
                }
                .sheet(isPresented: $showInput) {
                    TestInputView(tests: $testStore.tests)
                }
            } else {
                VStack {
                    Image(systemName: "heart.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.blue)
                    Text("Welcome to Sperm Test Results")
                        .font(.title2)
                        .padding()
                    Button("Sign Up") {
                        showSignUp = true
                    }
                    .padding()
                    .buttonStyle(.borderedProminent)
                }
                .navigationTitle("Welcome")
                .sheet(isPresented: $showSignUp) {
                    SignUpView(isLoggedIn: $isLoggedIn)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
