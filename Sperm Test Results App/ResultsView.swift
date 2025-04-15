import SwiftUI

struct ResultsView: View {
    let test: SpermTest

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Sperm Test Results")
                    .font(.title)
                Text("Overall: \(test.overallStatus)")
                    .font(.headline)
                    .foregroundColor(test.overallStatus == "Normal" ? .green : .orange)
                SectionView(title: "Sperm Analysis", status: test.analysisStatus) {
                    Text("Appearance: \(test.appearance.rawValue.capitalized)")
                    Text("Liquefaction: \(test.liquefaction.rawValue.capitalized)")
                    Text("Consistency: \(test.consistency.rawValue.capitalized)")
                    Text("Semen Quantity: \(test.semenQuantity, specifier: "%.1f") mL")
                    Text("pH: \(test.pH, specifier: "%.1f")")
                }
                SectionView(title: "Sperm Motility", status: test.motilityStatus) {
                    Text("Total Mobility: \(test.totalMobility, specifier: "%.1f")%")
                    Text("Progressive: \(test.progressiveMobility, specifier: "%.1f")%")
                    Text("Non-progressive: \(test.nonProgressiveMobility, specifier: "%.1f")%")
                    Text("Travel Speed: \(test.travelSpeed, specifier: "%.1f") mm/sec")
                    Text("Mobility Index: \(test.mobilityIndex, specifier: "%.1f")%")
                    Text("Still: \(test.still, specifier: "%.1f")%")
                    Text("Agglutination: \(test.agglutination.rawValue.capitalized)")
                }
                SectionView(title: "Sperm Concentration", status: test.concentrationStatus) {
                    Text("Concentration: \(test.spermConcentration, specifier: "%.1f") million/mL")
                    Text("Total Spermatozoa: \(test.totalSpermatozoa, specifier: "%.1f") million/mL")
                    Text("Functional: \(test.functionalSpermatozoa, specifier: "%.1f") million/mL")
                    Text("Round Cells: \(test.roundCells, specifier: "%.1f") million/mL")
                    Text("Leukocytes: \(test.leukocytes, specifier: "%.1f") million/mL")
                    Text("Live Spermatozoa: \(test.liveSpermatozoa, specifier: "%.1f")%")
                }
                SectionView(title: "Sperm Morphology", status: test.morphologyStatus) {
                    Text("Rate: \(test.morphologyRate, specifier: "%.1f")%")
                    Text("Pathology: \(test.pathology, specifier: "%.1f")%")
                    Text("Head Defect: \(test.headDefect, specifier: "%.1f")%")
                    Text("Neck Defect: \(test.neckDefect, specifier: "%.1f")%")
                    Text("Tail Defect: \(test.tailDefect, specifier: "%.1f")%")
                }
                Text("Note: Consult a doctor for professional advice. This app is for informational purposes only.")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .padding()
            }
            .padding()
        }
        .navigationTitle("Results")
    }
}

struct SectionView<Content: View>: View {
    let title: String
    let status: String
    let content: Content

    init(title: String, status: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.status = status
        self.content = content()
    }

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(title)
                    .font(.headline)
                Spacer()
                Text(status)
                    .font(.subheadline)
                    .foregroundColor(status == "Normal" ? .green : status == "Low" ? .red : .orange)
            }
            content
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(10)
    }
}

#Preview {
    ResultsView(test: SpermTest(
        appearance: .normal,
        liquefaction: .normal,
        consistency: .medium,
        semenQuantity: 2.0,
        pH: 7.4,
        totalMobility: 50,
        progressiveMobility: 35,
        nonProgressiveMobility: 15,
        travelSpeed: 25,
        mobilityIndex: 60,
        still: 10,
        agglutination: .mild,
        spermConcentration: 20,
        totalSpermatozoa: 40,
        functionalSpermatozoa: 15,
        roundCells: 1,
        leukocytes: 0.5,
        liveSpermatozoa: 80,
        morphologyRate: 5,
        pathology: 95,
        headDefect: 50,
        neckDefect: 30,
        tailDefect: 20,
        date: Date()
    ))
}
