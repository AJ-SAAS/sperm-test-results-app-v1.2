import SwiftUI

struct ContentView: View {
    @StateObject private var testStore = TestStore()
    @State private var isLoggedIn = UserDefaults.standard.string(forKey: "userEmail") != nil
    @State private var showSignUp = false
    @State private var showInput = false

    var body: some View {
        NavigationStack {
            if isLoggedIn {
                VStack {
                    if testStore.tests.isEmpty {
                        Text("No Tests Yet")
                            .font(.title2)
                            .padding()
                        Button("Add Your First Test") {
                            showInput = true
                        }
                        .buttonStyle(.borderedProminent)
                    } else {
                        VStack {
                            Text("Latest Test Results")
                                .font(.title2)
                            if let latest = testStore.tests.last {
                                DashboardSummary(test: latest)
                            }
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
                        }
                    }
                }
                .navigationTitle("Sperm Test Dashboard")
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

struct DashboardSummary: View {
    let test: SpermTest

    var body: some View {
        VStack {
            Text("Overall: \(test.overallStatus)")
                .font(.headline)
                .foregroundColor(test.overallStatus == "Normal" ? .green : .orange)
            HStack {
                StatusBox(title: "Analysis", status: test.analysisStatus)
                StatusBox(title: "Motility", status: test.motilityStatus)
            }
            HStack {
                StatusBox(title: "Concentration", status: test.concentrationStatus)
                StatusBox(title: "Morphology", status: test.morphologyStatus)
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(10)
        .padding()
    }
}

struct StatusBox: View {
    let title: String
    let status: String

    var body: some View {
        VStack {
            Text(title)
                .font(.caption)
            Text(status)
                .font(.subheadline)
                .foregroundColor(status == "Normal" ? .green : status == "Low" ? .red : .orange)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.white)
        .cornerRadius(8)
        .shadow(radius: 2)
    }
}

#Preview {
    ContentView()
}
