import Foundation

/// Mood tracking entry
struct MoodEntry: Identifiable, Codable {
    let id: UUID
    let date: Date
    let mood: Mood
    let notes: String?

    init(id: UUID = UUID(), date: Date = Date(), mood: Mood, notes: String? = nil) {
        self.id = id
        self.date = date
        self.mood = mood
        self.notes = notes
    }

    /// Mood levels from excellent to terrible
    enum Mood: String, Codable, CaseIterable {
        case excellent = "excellent"
        case good = "good"
        case okay = "okay"
        case bad = "bad"
        case terrible = "terrible"

        /// Emoji representation of mood
        var emoji: String {
            switch self {
            case .excellent: return "😄"
            case .good: return "🙂"
            case .okay: return "😐"
            case .bad: return "😟"
            case .terrible: return "😢"
            }
        }

        /// Localized mood name
        var localizedName: String {
            switch self {
            case .excellent: return NSLocalizedString("mood.excellent", comment: "")
            case .good: return NSLocalizedString("mood.good", comment: "")
            case .okay: return NSLocalizedString("mood.okay", comment: "")
            case .bad: return NSLocalizedString("mood.bad", comment: "")
            case .terrible: return NSLocalizedString("mood.terrible", comment: "")
            }
        }

        /// Color identifier for UI
        var color: String {
            switch self {
            case .excellent: return "green"
            case .good: return "blue"
            case .okay: return "gray"
            case .bad: return "orange"
            case .terrible: return "red"
            }
        }

        /// Numeric value for average calculations
        var numericValue: Double {
            switch self {
            case .excellent: return 5.0
            case .good: return 4.0
            case .okay: return 3.0
            case .bad: return 2.0
            case .terrible: return 1.0
            }
        }
    }
}
