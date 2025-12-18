import Foundation

struct Achievement: Identifiable, Codable {
    let id: UUID
    let daysRequired: Int
    let title: String
    let description: String
    let badgeIcon: String
    let color: String

    static let achievements: [Achievement] = [
        Achievement(
            id: UUID(),
            daysRequired: 1,
            title: "Первый день",
            description: "Вы сделали первый шаг к новой жизни!",
            badgeIcon: "1.circle.fill",
            color: "blue"
        ),
        Achievement(
            id: UUID(),
            daysRequired: 3,
            title: "Три дня",
            description: "Самое трудное позади!",
            badgeIcon: "3.circle.fill",
            color: "green"
        ),
        Achievement(
            id: UUID(),
            daysRequired: 7,
            title: "Первая неделя",
            description: "Целая неделя трезвости!",
            badgeIcon: "7.circle.fill",
            color: "purple"
        ),
        Achievement(
            id: UUID(),
            daysRequired: 14,
            title: "Две недели",
            description: "Вы на правильном пути!",
            badgeIcon: "14.circle.fill",
            color: "orange"
        ),
        Achievement(
            id: UUID(),
            daysRequired: 30,
            title: "Первый месяц",
            description: "Невероятное достижение!",
            badgeIcon: "star.circle.fill",
            color: "yellow"
        ),
        Achievement(
            id: UUID(),
            daysRequired: 60,
            title: "Два месяца",
            description: "Ваша сила воли впечатляет!",
            badgeIcon: "flame.fill",
            color: "red"
        ),
        Achievement(
            id: UUID(),
            daysRequired: 90,
            title: "Три месяца",
            description: "Новые привычки укоренились!",
            badgeIcon: "bolt.circle.fill",
            color: "cyan"
        ),
        Achievement(
            id: UUID(),
            daysRequired: 180,
            title: "Полгода",
            description: "Половина года трезвости!",
            badgeIcon: "gift.fill",
            color: "pink"
        ),
        Achievement(
            id: UUID(),
            daysRequired: 365,
            title: "Год трезвости",
            description: "Легендарное достижение! Целый год!",
            badgeIcon: "crown.fill",
            color: "gold"
        ),
        Achievement(
            id: UUID(),
            daysRequired: 730,
            title: "Два года",
            description: "Вы невероятны!",
            badgeIcon: "trophy.fill",
            color: "silver"
        )
    ]

    func isUnlocked(daysSober: Int) -> Bool {
        return daysSober >= daysRequired
    }
}
