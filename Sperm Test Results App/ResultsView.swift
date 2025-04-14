import SwiftUI

struct ResultsView: View {
    let test: SpermTest

    var body: some View {
        VStack(spacing: 20) {
            Text("Test Results")
                .font(.title)
            VStack(alignment: .leading) {
                Text("Date: \(test.date, format: .dateTime)")
                Text("Concentration: \(test.concentration, specifier: "%.1f") million/mL")
                Text("Motility: \(test.motility, specifier: "%.1f")%")
                Text("Volume: \(test.volume, specifier: "%.1f") mL")
                Text("Status: \(test.fertilityStatus)")
                    .font(.headline)
                    .foregroundColor(test.fertilityStatus == "Normal" ? .green : .red)
            }
            .padding()
            Text("Note: Consult a doctor for professional advice. This app is for informational purposes only.")
                .font(.caption)
                .foregroundColor(.gray)
                .padding()
        }
        .padding()
        .navigationTitle("Results")
    }
}

#Preview {
    ResultsView(test: SpermTest(concentration: 20, motility: 50, volume: 2, date: Date()))
}
