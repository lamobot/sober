import Foundation
import UserNotifications

/// Service for managing push notifications
class NotificationService {
    static let shared = NotificationService()

    private init() {}

    /// Request notification permissions from user
    func requestAuthorization(completion: @escaping (Bool) -> Void) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            DispatchQueue.main.async {
                completion(granted)
            }
        }
    }

    /// Schedule recurring notifications based on frequency
    func scheduleNotifications(frequency: Settings.NotificationFrequency, sobrietyData: SobrietyData) {
        cancelAllNotifications()

        let content = UNMutableNotificationContent()
        content.sound = .default

        var dateComponents = DateComponents()

        switch frequency {
        case .daily:
            dateComponents.hour = 9
            dateComponents.minute = 0
            content.title = NSLocalizedString("notification.title.daily", comment: "")
            content.body = NSLocalizedString("notification.body.daily", comment: "")

        case .weekly:
            dateComponents.weekday = 2 // Monday
            dateComponents.hour = 9
            dateComponents.minute = 0
            content.title = NSLocalizedString("notification.title.weekly", comment: "")
            content.body = String(format: NSLocalizedString("notification.body.weekly", comment: ""), sobrietyData.weeksSober)

        case .monthly:
            dateComponents.day = 1
            dateComponents.hour = 9
            dateComponents.minute = 0
            content.title = NSLocalizedString("notification.title.monthly", comment: "")
            content.body = String(format: NSLocalizedString("notification.body.monthly", comment: ""), sobrietyData.moneySaved)
        }

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: "soberReminder", content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error)")
            }
        }
    }

    /// Schedule notification for reaching a health milestone
    func scheduleMilestoneNotification(milestone: HealthMilestone, date: Date) {
        let content = UNMutableNotificationContent()
        content.title = NSLocalizedString("notification.milestone.title", comment: "")
        content.body = String(format: NSLocalizedString("notification.milestone.body", comment: ""), milestone.title, milestone.description)
        content.sound = .default

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: date.timeIntervalSinceNow, repeats: false)
        let request = UNNotificationRequest(identifier: "milestone_\(milestone.id)", content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request)
    }

    /// Cancel all pending notifications
    func cancelAllNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
}
