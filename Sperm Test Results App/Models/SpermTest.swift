import Foundation

struct SpermTest: Identifiable, Codable {
    let id = UUID()
    let concentration: Double // million/mL
    let motility: Double // %
    let volume: Double // mL
    let date: Date

    var fertilityStatus: String {
        if concentration >= 15 && motility >= 40 && volume >= 1.5 {
            return "Normal"
        } else {
            return "Low"
        }
    }
}
