import Foundation
import UserNotifications

class NotificationService {
    static let shared = NotificationService()

    private init() {}

    func requestAuthorization(completion: @escaping (Bool) -> Void) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            DispatchQueue.main.async {
                completion(granted)
            }
        }
    }

    func scheduleNotifications(frequency: Settings.NotificationFrequency, sobrietyData: SobrietyData) {
        cancelAllNotifications()

        let content = UNMutableNotificationContent()
        content.sound = .default

        var dateComponents = DateComponents()

        switch frequency {
        case .daily:
            dateComponents.hour = 9
            dateComponents.minute = 0
            content.title = "Отличная работа!"
            content.body = "Посмотрите на свой прогресс в Sober"

        case .weekly:
            dateComponents.weekday = 2 // Monday
            dateComponents.hour = 9
            dateComponents.minute = 0
            content.title = "Еженедельный отчет"
            content.body = "Вы уже \(sobrietyData.weeksSober) недель трезвы! Продолжайте в том же духе!"

        case .monthly:
            dateComponents.day = 1
            dateComponents.hour = 9
            dateComponents.minute = 0
            content.title = "Месячный отчет"
            content.body = "Прошел еще один месяц трезвости. Вы сэкономили \(String(format: "%.0f", sobrietyData.moneySaved))€!"
        }

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: "soberReminder", content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error)")
            }
        }
    }

    func scheduleMilestoneNotification(milestone: HealthMilestone, date: Date) {
        let content = UNMutableNotificationContent()
        content.title = "Новое достижение! 🎉"
        content.body = "\(milestone.title): \(milestone.description)"
        content.sound = .default

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: date.timeIntervalSinceNow, repeats: false)
        let request = UNNotificationRequest(identifier: "milestone_\(milestone.id)", content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request)
    }

    func cancelAllNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
}
