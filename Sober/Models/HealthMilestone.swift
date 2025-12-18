import Foundation

struct HealthMilestone: Identifiable, Codable {
    let id: UUID
    let daysRequired: Int
    let title: String
    let description: String
    let icon: String

    static let milestones: [HealthMilestone] = [
        HealthMilestone(
            id: UUID(),
            daysRequired: 1,
            title: "24 часа",
            description: "Уровень алкоголя в крови возвращается к нулю. Начинается детоксикация.",
            icon: "heart.fill"
        ),
        HealthMilestone(
            id: UUID(),
            daysRequired: 3,
            title: "3 дня",
            description: "Улучшается качество сна, повышается уровень энергии.",
            icon: "moon.stars.fill"
        ),
        HealthMilestone(
            id: UUID(),
            daysRequired: 7,
            title: "1 неделя",
            description: "Печень начинает восстанавливаться, улучшается состояние кожи.",
            icon: "leaf.fill"
        ),
        HealthMilestone(
            id: UUID(),
            daysRequired: 14,
            title: "2 недели",
            description: "Значительное улучшение пищеварения и иммунной системы.",
            icon: "shield.fill"
        ),
        HealthMilestone(
            id: UUID(),
            daysRequired: 30,
            title: "1 месяц",
            description: "Нормализуется кровяное давление, улучшается память и концентрация.",
            icon: "brain.head.profile"
        ),
        HealthMilestone(
            id: UUID(),
            daysRequired: 90,
            title: "3 месяца",
            description: "Полное восстановление печени (если не было серьезных повреждений).",
            icon: "heart.circle.fill"
        ),
        HealthMilestone(
            id: UUID(),
            daysRequired: 180,
            title: "6 месяцев",
            description: "Значительное улучшение психического здоровья и эмоциональной стабильности.",
            icon: "star.fill"
        ),
        HealthMilestone(
            id: UUID(),
            daysRequired: 365,
            title: "1 год",
            description: "Снижение риска сердечно-сосудистых заболеваний, полная нормализация функций организма.",
            icon: "crown.fill"
        )
    ]

    func isAchieved(daysSober: Int) -> Bool {
        return daysSober >= daysRequired
    }
}
