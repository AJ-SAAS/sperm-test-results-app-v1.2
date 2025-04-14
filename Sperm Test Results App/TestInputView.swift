import SwiftUI

struct TestInputView: View {
    @State private var concentration = ""
    @State private var motility = ""
    @State private var volume = ""
    @Environment(\.dismiss) var dismiss
    @Binding var tests: [SpermTest]

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Test Parameters")) {
                    TextField("Concentration (million/mL)", text: $concentration)
                        .keyboardType(.decimalPad)
                    TextField("Motility (%)", text: $motility)
                        .keyboardType(.decimalPad)
                    TextField("Volume (mL)", text: $volume)
                        .keyboardType(.decimalPad)
                }
                Button("Submit") {
                    if let conc = Double(concentration), let mot = Double(motility), let vol = Double(volume) {
                        let test = SpermTest(concentration: conc, motility: mot, volume: vol, date: Date())
                        tests.append(test)
                        dismiss()
                    }
                }
                .disabled(concentration.isEmpty || motility.isEmpty || volume.isEmpty)
            }
            .navigationTitle("Enter Test Data")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
            }
        }
    }
}

#Preview {
    TestInputView(tests: .constant([]))
}
