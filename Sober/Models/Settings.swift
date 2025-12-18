import Foundation

struct Settings: Codable {
    var currency: String = "EUR"
    var notificationsEnabled: Bool = true
    var notificationFrequency: NotificationFrequency = .weekly

    enum NotificationFrequency: String, Codable, CaseIterable {
        case daily = "Daily"
        case weekly = "Weekly"
        case monthly = "Monthly"

        var localizedName: String {
            switch self {
            case .daily: return "Ежедневно"
            case .weekly: return "Еженедельно"
            case .monthly: return "Ежемесячно"
            }
        }
    }
}
