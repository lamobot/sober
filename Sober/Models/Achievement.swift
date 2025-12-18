import Foundation

/// Achievement/badge for sobriety milestones
struct Achievement: Identifiable, Codable {
    let id: UUID
    let daysRequired: Int
    let titleKey: String
    let descriptionKey: String
    let badgeIcon: String
    let color: String

    /// Localized achievement title
    var title: String {
        NSLocalizedString(titleKey, comment: "")
    }

    /// Localized achievement description
    var description: String {
        NSLocalizedString(descriptionKey, comment: "")
    }

    /// Predefined achievements for different sobriety periods
    static let achievements: [Achievement] = [
        Achievement(
            id: UUID(),
            daysRequired: 1,
            titleKey: "achievement.day1.title",
            descriptionKey: "achievement.day1.description",
            badgeIcon: "1.circle.fill",
            color: "blue"
        ),
        Achievement(
            id: UUID(),
            daysRequired: 3,
            titleKey: "achievement.day3.title",
            descriptionKey: "achievement.day3.description",
            badgeIcon: "3.circle.fill",
            color: "green"
        ),
        Achievement(
            id: UUID(),
            daysRequired: 7,
            titleKey: "achievement.week1.title",
            descriptionKey: "achievement.week1.description",
            badgeIcon: "7.circle.fill",
            color: "purple"
        ),
        Achievement(
            id: UUID(),
            daysRequired: 14,
            titleKey: "achievement.week2.title",
            descriptionKey: "achievement.week2.description",
            badgeIcon: "14.circle.fill",
            color: "orange"
        ),
        Achievement(
            id: UUID(),
            daysRequired: 30,
            titleKey: "achievement.month1.title",
            descriptionKey: "achievement.month1.description",
            badgeIcon: "star.circle.fill",
            color: "yellow"
        ),
        Achievement(
            id: UUID(),
            daysRequired: 60,
            titleKey: "achievement.month2.title",
            descriptionKey: "achievement.month2.description",
            badgeIcon: "flame.fill",
            color: "red"
        ),
        Achievement(
            id: UUID(),
            daysRequired: 90,
            titleKey: "achievement.month3.title",
            descriptionKey: "achievement.month3.description",
            badgeIcon: "bolt.circle.fill",
            color: "cyan"
        ),
        Achievement(
            id: UUID(),
            daysRequired: 180,
            titleKey: "achievement.month6.title",
            descriptionKey: "achievement.month6.description",
            badgeIcon: "gift.fill",
            color: "pink"
        ),
        Achievement(
            id: UUID(),
            daysRequired: 365,
            titleKey: "achievement.year1.title",
            descriptionKey: "achievement.year1.description",
            badgeIcon: "crown.fill",
            color: "gold"
        ),
        Achievement(
            id: UUID(),
            daysRequired: 730,
            titleKey: "achievement.year2.title",
            descriptionKey: "achievement.year2.description",
            badgeIcon: "trophy.fill",
            color: "silver"
        )
    ]

    /// Check if achievement is unlocked based on days sober
    func isUnlocked(daysSober: Int) -> Bool {
        return daysSober >= daysRequired
    }
}
