import Foundation

/// Health milestone representing recovery stages
struct HealthMilestone: Identifiable, Codable {
    let id: UUID
    let daysRequired: Int
    let titleKey: String
    let descriptionKey: String
    let icon: String

    /// Localized title
    var title: String {
        NSLocalizedString(titleKey, comment: "")
    }

    /// Localized description
    var description: String {
        NSLocalizedString(descriptionKey, comment: "")
    }

    /// Predefined health milestones based on medical research
    static let milestones: [HealthMilestone] = [
        HealthMilestone(
            id: UUID(),
            daysRequired: 1,
            titleKey: "health.milestone.day1.title",
            descriptionKey: "health.milestone.day1.description",
            icon: "heart.fill"
        ),
        HealthMilestone(
            id: UUID(),
            daysRequired: 3,
            titleKey: "health.milestone.day3.title",
            descriptionKey: "health.milestone.day3.description",
            icon: "moon.stars.fill"
        ),
        HealthMilestone(
            id: UUID(),
            daysRequired: 7,
            titleKey: "health.milestone.week1.title",
            descriptionKey: "health.milestone.week1.description",
            icon: "leaf.fill"
        ),
        HealthMilestone(
            id: UUID(),
            daysRequired: 14,
            titleKey: "health.milestone.week2.title",
            descriptionKey: "health.milestone.week2.description",
            icon: "shield.fill"
        ),
        HealthMilestone(
            id: UUID(),
            daysRequired: 30,
            titleKey: "health.milestone.month1.title",
            descriptionKey: "health.milestone.month1.description",
            icon: "brain.head.profile"
        ),
        HealthMilestone(
            id: UUID(),
            daysRequired: 90,
            titleKey: "health.milestone.month3.title",
            descriptionKey: "health.milestone.month3.description",
            icon: "heart.circle.fill"
        ),
        HealthMilestone(
            id: UUID(),
            daysRequired: 180,
            titleKey: "health.milestone.month6.title",
            descriptionKey: "health.milestone.month6.description",
            icon: "star.fill"
        ),
        HealthMilestone(
            id: UUID(),
            daysRequired: 365,
            titleKey: "health.milestone.year1.title",
            descriptionKey: "health.milestone.year1.description",
            icon: "crown.fill"
        )
    ]

    /// Check if milestone is achieved based on days sober
    func isAchieved(daysSober: Int) -> Bool {
        return daysSober >= daysRequired
    }
}
