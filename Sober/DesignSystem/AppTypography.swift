import SwiftUI

/// Централизованная система типографики
enum AppTypography {
    // MARK: - Display (Extra Large)

    /// Огромный текст для hero sections (72pt)
    static let displayLarge = Font.system(size: 72, weight: .bold, design: .rounded)

    /// Большой display текст (48pt)
    static let displayMedium = Font.system(size: 48, weight: .bold, design: .rounded)

    /// Средний display текст (36pt)
    static let displaySmall = Font.system(size: 36, weight: .bold, design: .rounded)

    // MARK: - Headlines

    /// Крупный заголовок
    static let headlineLarge = Font.title

    /// Средний заголовок
    static let headlineMedium = Font.title2

    /// Маленький заголовок
    static let headlineSmall = Font.title3

    // MARK: - Body

    /// Основной текст
    static let bodyLarge = Font.body

    /// Меньший основной текст
    static let bodyMedium = Font.callout

    /// Маленький основной текст
    static let bodySmall = Font.subheadline

    // MARK: - Labels

    /// Крупная метка
    static let labelLarge = Font.headline

    /// Средняя метка
    static let labelMedium = Font.subheadline

    /// Маленькая метка
    static let labelSmall = Font.caption

    /// Очень маленькая метка
    static let labelTiny = Font.caption2

    // MARK: - Custom Sizes

    /// Иконка emoji (60pt)
    static let emojiLarge = Font.system(size: 60)

    /// Иконка badge (40pt)
    static let iconBadge = Font.system(size: 40)

    /// Счетчик прогресса (36pt bold)
    static let counterLarge = Font.system(size: 36, weight: .bold)
}

// MARK: - View Extensions

extension View {
    /// Применить стиль display large
    func displayLarge() -> some View {
        self.font(AppTypography.displayLarge)
    }

    /// Применить стиль headline
    func headline(_ size: HeadlineSize = .medium) -> some View {
        let font: Font = switch size {
        case .large: AppTypography.headlineLarge
        case .medium: AppTypography.headlineMedium
        case .small: AppTypography.headlineSmall
        }
        return self.font(font)
    }

    /// Применить стиль body
    func body(_ size: BodySize = .large) -> some View {
        let font: Font = switch size {
        case .large: AppTypography.bodyLarge
        case .medium: AppTypography.bodyMedium
        case .small: AppTypography.bodySmall
        }
        return self.font(font)
    }

    /// Применить стиль label
    func label(_ size: LabelSize = .medium) -> some View {
        let font: Font = switch size {
        case .large: AppTypography.labelLarge
        case .medium: AppTypography.labelMedium
        case .small: AppTypography.labelSmall
        case .tiny: AppTypography.labelTiny
        }
        return self.font(font)
    }
}

// MARK: - Supporting Types

enum HeadlineSize {
    case large, medium, small
}

enum BodySize {
    case large, medium, small
}

enum LabelSize {
    case large, medium, small, tiny
}
