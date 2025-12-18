import SwiftUI

/// Централизованная цветовая система приложения
enum AppColor {
    // MARK: - Primary Colors

    /// Основной акцентный цвет приложения
    static let primary = Color.teal

    /// Цвет успеха, позитивных действий
    static let success = Color.green

    /// Цвет информации
    static let info = Color.blue

    /// Цвет предупреждений
    static let warning = Color.orange

    /// Цвет ошибок, негативных действий
    static let danger = Color.red

    // MARK: - Text Colors

    /// Основной текст
    static let textPrimary = Color.primary

    /// Вторичный текст (описания, метки)
    static let textSecondary = Color.secondary

    /// Tertiary text (ещё менее важный)
    static let textTertiary = Color.gray

    // MARK: - Background Colors

    /// Основной фон приложения
    static let background = Color(.systemBackground)

    /// Вторичный фон (карточки, группы)
    static let backgroundSecondary = Color(.systemGray6)

    /// Tertiary background (вложенные карточки)
    static let backgroundTertiary = Color(.systemGray5)

    // MARK: - Stats Colors

    /// Цвет для денег/финансов
    static let money = Color.green

    /// Цвет для времени
    static let time = Color.blue

    /// Цвет для дней/прогресса
    static let days = Color.orange

    /// Цвет для milestone/достижений
    static let milestone = Color.purple

    // MARK: - Achievement Badge Colors

    enum Badge {
        static let blue = Color.blue
        static let green = Color.green
        static let purple = Color.purple
        static let orange = Color.orange
        static let yellow = Color.yellow
        static let red = Color.red
        static let cyan = Color.cyan
        static let pink = Color.pink
        static let gold = Color.yellow // Gold badge
        static let silver = Color.gray // Silver badge

        /// Получить цвет по строковому идентификатору
        static func color(for name: String) -> Color {
            switch name.lowercased() {
            case "blue": return blue
            case "green": return green
            case "purple": return purple
            case "orange": return orange
            case "yellow", "gold": return gold
            case "red": return red
            case "cyan": return cyan
            case "pink": return pink
            case "silver": return silver
            default: return .gray
            }
        }
    }

    // MARK: - Mood Colors

    enum Mood {
        static let excellent = Color.green
        static let good = Color.blue
        static let okay = Color.yellow
        static let bad = Color.orange
        static let terrible = Color.red
    }

    // MARK: - Opacity Levels

    enum Opacity {
        static let subtle: Double = 0.1
        static let light: Double = 0.2
        static let medium: Double = 0.5
        static let disabled: Double = 0.6
        static let opaque: Double = 1.0
    }
}

// MARK: - Color Extensions

extension Color {
    /// Светлый оттенок для фонов
    var lightBackground: Color {
        return self.opacity(AppColor.Opacity.subtle)
    }
}
