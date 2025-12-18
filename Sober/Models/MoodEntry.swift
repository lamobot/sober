import Foundation

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

    enum Mood: String, Codable, CaseIterable {
        case excellent = "excellent"
        case good = "good"
        case okay = "okay"
        case bad = "bad"
        case terrible = "terrible"

        var emoji: String {
            switch self {
            case .excellent: return "😄"
            case .good: return "🙂"
            case .okay: return "😐"
            case .bad: return "😟"
            case .terrible: return "😢"
            }
        }

        var localizedName: String {
            switch self {
            case .excellent: return "Отлично"
            case .good: return "Хорошо"
            case .okay: return "Нормально"
            case .bad: return "Плохо"
            case .terrible: return "Ужасно"
            }
        }

        var color: String {
            switch self {
            case .excellent: return "green"
            case .good: return "blue"
            case .okay: return "gray"
            case .bad: return "orange"
            case .terrible: return "red"
            }
        }
    }
}
