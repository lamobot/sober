import Foundation

/// User settings and preferences
struct Settings: Codable {
    /// Display currency (default: EUR)
    var currency: String = "EUR"

    /// Whether notifications are enabled
    var notificationsEnabled: Bool = true

    /// Notification frequency setting
    var notificationFrequency: NotificationFrequency = .weekly

    /// Selected app language (nil = system default)
    var selectedLanguage: String?

    /// Notification frequency options
    enum NotificationFrequency: String, Codable, CaseIterable {
        case daily = "daily"
        case weekly = "weekly"
        case monthly = "monthly"

        /// Localized display name
        var localizedName: String {
            switch self {
            case .daily: return NSLocalizedString("notification.daily", comment: "")
            case .weekly: return NSLocalizedString("notification.weekly", comment: "")
            case .monthly: return NSLocalizedString("notification.monthly", comment: "")
            }
        }
    }
}
