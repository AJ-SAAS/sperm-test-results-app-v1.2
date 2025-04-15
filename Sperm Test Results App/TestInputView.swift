import SwiftUI

struct TestInputView: View {
    @State private var step = 1
    @State private var analysis = AnalysisData()
    @State private var motility = MotilityData()
    @State private var concentration = ConcentrationData()
    @State private var morphology = MorphologyData()
    @Environment(\.dismiss) var dismiss
    @Binding var tests: [SpermTest]

    var body: some View {
        NavigationStack {
            VStack {
                ProgressView(value: Double(step), total: 4)
                    .padding()
                Group {
                    if step == 1 {
                        AnalysisForm(analysis: $analysis)
                    } else if step == 2 {
                        MotilityForm(motility: $motility)
                    } else if step == 3 {
                        ConcentrationForm(concentration: $concentration)
                    } else if step == 4 {
                        MorphologyForm(morphology: $morphology)
                    }
                }
                .padding()
                HStack {
                    if step > 1 {
                        Button("Back") { step -= 1 }
                            .buttonStyle(.bordered)
                    }
                    Spacer()
                    if step < 4 {
                        Button("Next") { step += 1 }
                            .buttonStyle(.borderedProminent)
                            .disabled(!isStepValid())
                    } else {
                        Button("Submit") {
                            let test = SpermTest(
                                appearance: analysis.appearance,
                                liquefaction: analysis.liquefaction,
                                consistency: analysis.consistency,
                                semenQuantity: analysis.semenQuantity,
                                pH: analysis.pH,
                                totalMobility: motility.totalMobility,
                                progressiveMobility: motility.progressiveMobility,
                                nonProgressiveMobility: motility.nonProgressiveMobility,
                                travelSpeed: motility.travelSpeed,
                                mobilityIndex: motility.mobilityIndex,
                                still: motility.still,
                                agglutination: motility.agglutination,
                                spermConcentration: concentration.spermConcentration,
                                totalSpermatozoa: concentration.totalSpermatozoa,
                                functionalSpermatozoa: concentration.functionalSpermatozoa,
                                roundCells: concentration.roundCells,
                                leukocytes: concentration.leukocytes,
                                liveSpermatozoa: concentration.liveSpermatozoa,
                                morphologyRate: morphology.morphologyRate,
                                pathology: morphology.pathology,
                                headDefect: morphology.headDefect,
                                neckDefect: morphology.neckDefect,
                                tailDefect: morphology.tailDefect,
                                date: Date()
                            )
                            tests.append(test)
                            dismiss()
                        }
                        .buttonStyle(.borderedProminent)
                        .disabled(!isStepValid())
                    }
                }
                .padding()
            }
            .navigationTitle("Enter Test Data")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
            }
            .onDisappear {
                savePartialData()
            }
        }
    }

    func isStepValid() -> Bool {
        switch step {
        case 1:
            return analysis.pH >= 0 && analysis.pH <= 14 && analysis.semenQuantity >= 0
        case 2:
            return motility.totalMobility >= 0 && motility.totalMobility <= 100 &&
                   motility.progressiveMobility >= 0 && motility.progressiveMobility <= 100 &&
                   motility.nonProgressiveMobility >= 0 && motility.nonProgressiveMobility <= 100 &&
                   motility.mobilityIndex >= 0 && motility.mobilityIndex <= 100 &&
                   motility.still >= 0 && motility.still <= 100 &&
                   motility.travelSpeed >= 0
        case 3:
            return concentration.spermConcentration >= 0 &&
                   concentration.totalSpermatozoa >= 0 &&
                   concentration.functionalSpermatozoa >= 0 &&
                   concentration.roundCells >= 0 &&
                   concentration.leukocytes >= 0 &&
                   concentration.liveSpermatozoa >= 0 && concentration.liveSpermatozoa <= 100
        case 4:
            return morphology.morphologyRate >= 0 && morphology.morphologyRate <= 100 &&
                   morphology.pathology >= 0 && morphology.pathology <= 100 &&
                   morphology.headDefect >= 0 && morphology.headDefect <= 100 &&
                   morphology.neckDefect >= 0 && morphology.neckDefect <= 100 &&
                   morphology.tailDefect >= 0 && morphology.tailDefect <= 100
        default:
            return false
        }
    }

    func savePartialData() {
        // Save to UserDefaults for recovery
        let encoder = JSONEncoder()
        if let analysisData = try? encoder.encode(analysis) {
            UserDefaults.standard.set(analysisData, forKey: "partialAnalysis")
        }
        if let motilityData = try? encoder.encode(motility) {
            UserDefaults.standard.set(motilityData, forKey: "partialMotility")
        }
        if let concentrationData = try? encoder.encode(concentration) {
            UserDefaults.standard.set(concentrationData, forKey: "partialConcentration")
        }
        if let morphologyData = try? encoder.encode(morphology) {
            UserDefaults.standard.set(morphologyData, forKey: "partialMorphology")
        }
    }
}

struct AnalysisData: Codable {
    var appearance: Appearance = .normal
    var liquefaction: Liquefaction = .normal
    var consistency: Consistency = .thin
    var semenQuantity: Double = 0
    var pH: Double = 7.2
}

struct MotilityData: Codable {
    var totalMobility: Double = 0
    var progressiveMobility: Double = 0
    var nonProgressiveMobility: Double = 0
    var travelSpeed: Double = 0
    var mobilityIndex: Double = 0
    var still: Double = 0
    var agglutination: Agglutination = .mild
}

struct ConcentrationData: Codable {
    var spermConcentration: Double = 0
    var totalSpermatozoa: Double = 0
    var functionalSpermatozoa: Double = 0
    var roundCells: Double = 0
    var leukocytes: Double = 0
    var liveSpermatozoa: Double = 0
}

struct MorphologyData: Codable {
    var morphologyRate: Double = 0
    var pathology: Double = 0
    var headDefect: Double = 0
    var neckDefect: Double = 0
    var tailDefect: Double = 0
}

struct AnalysisForm: View {
    @Binding var analysis: AnalysisData

    var body: some View {
        Form {
            Picker("Appearance", selection: $analysis.appearance) {
                ForEach(Appearance.allCases, id: \.self) { Text($0.rawValue.capitalized) }
            }
            Picker("Liquefaction", selection: $analysis.liquefaction) {
                ForEach(Liquefaction.allCases, id: \.self) { Text($0.rawValue.capitalized) }
            }
            Picker("Consistency", selection: $analysis.consistency) {
                ForEach(Consistency.allCases, id: \.self) { Text($0.rawValue.capitalized) }
            }
            HStack {
                Text("Semen Quantity (mL)")
                Spacer()
                TextField("0", value: $analysis.semenQuantity, format: .number)
                    .keyboardType(.decimalPad)
                    .multilineTextAlignment(.trailing)
                    .frame(width: 100)
            }
            HStack {
                Text("pH (0–14)")
                Spacer()
                TextField("7.2", value: $analysis.pH, format: .number)
                    .keyboardType(.decimalPad)
                    .multilineTextAlignment(.trailing)
                    .frame(width: 100)
            }
        }
    }
}

struct MotilityForm: View {
    @Binding var motility: MotilityData

    var body: some View {
        Form {
            SliderField(label: "Total Mobility (%)", value: $motility.totalMobility, range: 0...100)
            SliderField(label: "Progressive Mobility (%)", value: $motility.progressiveMobility, range: 0...100)
            SliderField(label: "Non-progressive Mobility (%)", value: $motility.nonProgressiveMobility, range: 0...100)
            HStack {
                Text("Travel Speed (mm/sec)")
                Spacer()
                TextField("0", value: $motility.travelSpeed, format: .number)
                    .keyboardType(.decimalPad)
                    .multilineTextAlignment(.trailing)
                    .frame(width: 100)
            }
            SliderField(label: "Mobility Index (%)", value: $motility.mobilityIndex, range: 0...100)
            SliderField(label: "Still (%)", value: $motility.still, range: 0...100)
            Picker("Agglutination", selection: $motility.agglutination) {
                ForEach(Agglutination.allCases, id: \.self) { Text($0.rawValue.capitalized) }
            }
        }
    }
}

struct ConcentrationForm: View {
    @Binding var concentration: ConcentrationData

    var body: some View {
        Form {
            HStack {
                Text("Sperm Concentration (million/mL)")
                Spacer()
                TextField("0", value: $concentration.spermConcentration, format: .number)
                    .keyboardType(.decimalPad)
                    .multilineTextAlignment(.trailing)
                    .frame(width: 100)
            }
            HStack {
                Text("Total Spermatozoa (million/mL)")
                Spacer()
                TextField("0", value: $concentration.totalSpermatozoa, format: .number)
                    .keyboardType(.decimalPad)
                    .multilineTextAlignment(.trailing)
                    .frame(width: 100)
            }
            HStack {
                Text("Functional Spermatozoa (million/mL)")
                Spacer()
                TextField("0", value: $concentration.functionalSpermatozoa, format: .number)
                    .keyboardType(.decimalPad)
                    .multilineTextAlignment(.trailing)
                    .frame(width: 100)
            }
            HStack {
                Text("Round Cells (million/mL)")
                Spacer()
                TextField("0", value: $concentration.roundCells, format: .number)
                    .keyboardType(.decimalPad)
                    .multilineTextAlignment(.trailing)
                    .frame(width: 100)
            }
            HStack {
                Text("Leukocytes (million/mL)")
                Spacer()
                TextField("0", value: $concentration.leukocytes, format: .number)
                    .keyboardType(.decimalPad)
                    .multilineTextAlignment(.trailing)
                    .frame(width: 100)
            }
            SliderField(label: "Live Spermatozoa (%)", value: $concentration.liveSpermatozoa, range: 0...100)
        }
    }
}

struct MorphologyForm: View {
    @Binding var morphology: MorphologyData

    var body: some View {
        Form {
            SliderField(label: "Rate (%)", value: $morphology.morphologyRate, range: 0...100)
            SliderField(label: "Pathology (%)", value: $morphology.pathology, range: 0...100)
            SliderField(label: "Head Defect (%)", value: $morphology.headDefect, range: 0...100)
            SliderField(label: "Neck Defect (%)", value: $morphology.neckDefect, range: 0...100)
            SliderField(label: "Tail Defect (%)", value: $morphology.tailDefect, range: 0...100)
        }
    }
}

struct SliderField: View {
    let label: String
    @Binding var value: Double
    let range: ClosedRange<Double>

    var body: some View {
        VStack {
            HStack {
                Text(label)
                Spacer()
                Text("\(value, specifier: "%.1f")")
            }
            Slider(value: $value, in: range, step: 0.1)
        }
    }
}

#Preview {
    TestInputView(tests: .constant([]))
}
