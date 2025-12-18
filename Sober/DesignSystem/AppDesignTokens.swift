import SwiftUI

/// Дизайн токены - константы для размеров, радиусов, теней и т.д.
enum AppDesignTokens {
    // MARK: - Corner Radius

    enum CornerRadius {
        /// Маленький радиус (8pt)
        static let small: CGFloat = 8

        /// Стандартный радиус (12pt)
        static let medium: CGFloat = 12

        /// Большой радиус (16pt)
        static let large: CGFloat = 16

        /// Очень большой радиус (20pt)
        static let xlarge: CGFloat = 20

        /// Круглый (50% от высоты)
        static let circular: CGFloat = 1000
    }

    // MARK: - Border Width

    enum BorderWidth {
        /// Тонкая граница (1pt)
        static let thin: CGFloat = 1

        /// Стандартная граница (2pt)
        static let medium: CGFloat = 2

        /// Толстая граница (3pt)
        static let thick: CGFloat = 3

        /// Очень толстая граница (4pt)
        static let extraThick: CGFloat = 4
    }

    // MARK: - Icon Sizes

    enum IconSize {
        /// Маленькая иконка (16pt)
        static let small: CGFloat = 16

        /// Средняя иконка (24pt)
        static let medium: CGFloat = 24

        /// Большая иконка (32pt)
        static let large: CGFloat = 32

        /// Очень большая иконка (40pt)
        static let xlarge: CGFloat = 40

        /// Огромная иконка (48pt)
        static let xxlarge: CGFloat = 48

        /// Максимальная иконка (64pt)
        static let xxxlarge: CGFloat = 64
    }

    // MARK: - Frame Sizes

    enum FrameSize {
        /// Маленькая иконка в карточке (40pt)
        static let iconSmall: CGFloat = 40

        /// Средняя иконка в карточке (50pt)
        static let iconMedium: CGFloat = 50

        /// Badge размер (80pt)
        static let badge: CGFloat = 80

        /// Большой badge (100pt)
        static let badgeLarge: CGFloat = 100

        /// Круговой прогресс (120pt)
        static let progressCircle: CGFloat = 120

        /// Большой круговой прогресс (150pt)
        static let progressCircleLarge: CGFloat = 150
    }

    // MARK: - Shadow

    enum Shadow {
        /// Маленькая тень
        static let small = ShadowStyle(
            color: Color.black.opacity(0.05),
            radius: 2,
            x: 0,
            y: 1
        )

        /// Средняя тень
        static let medium = ShadowStyle(
            color: Color.black.opacity(0.1),
            radius: 4,
            x: 0,
            y: 2
        )

        /// Большая тень
        static let large = ShadowStyle(
            color: Color.black.opacity(0.15),
            radius: 8,
            x: 0,
            y: 4
        )

        struct ShadowStyle {
            let color: Color
            let radius: CGFloat
            let x: CGFloat
            let y: CGFloat
        }
    }

    // MARK: - Animation Duration

    enum AnimationDuration {
        /// Быстрая анимация (0.2s)
        static let fast: Double = 0.2

        /// Стандартная анимация (0.3s)
        static let medium: Double = 0.3

        /// Медленная анимация (0.5s)
        static let slow: Double = 0.5

        /// Очень медленная анимация (0.8s)
        static let verySlow: Double = 0.8
    }

    // MARK: - Grid Columns

    enum Grid {
        /// Две колонки для grid
        static let twoColumns = [
            GridItem(.flexible(), spacing: AppSpacing.md),
            GridItem(.flexible(), spacing: AppSpacing.md)
        ]

        /// Три колонки для grid
        static let threeColumns = [
            GridItem(.flexible(), spacing: AppSpacing.sm),
            GridItem(.flexible(), spacing: AppSpacing.sm),
            GridItem(.flexible(), spacing: AppSpacing.sm)
        ]
    }

    // MARK: - Line Height

    enum LineHeight {
        /// Компактная высота строки (1.2)
        static let compact: CGFloat = 1.2

        /// Стандартная высота строки (1.5)
        static let standard: CGFloat = 1.5

        /// Просторная высота строки (1.8)
        static let relaxed: CGFloat = 1.8
    }
}

// MARK: - View Extensions

extension View {
    /// Применить стандартный corner radius для карточки
    func cardCornerRadius() -> some View {
        self.cornerRadius(AppDesignTokens.CornerRadius.medium)
    }

    /// Применить corner radius для badge
    func badgeCornerRadius() -> some View {
        self.cornerRadius(AppDesignTokens.CornerRadius.large)
    }

    /// Применить маленькую тень
    func shadowSmall() -> some View {
        let shadow = AppDesignTokens.Shadow.small
        return self.shadow(
            color: shadow.color,
            radius: shadow.radius,
            x: shadow.x,
            y: shadow.y
        )
    }

    /// Применить среднюю тень
    func shadowMedium() -> some View {
        let shadow = AppDesignTokens.Shadow.medium
        return self.shadow(
            color: shadow.color,
            radius: shadow.radius,
            x: shadow.x,
            y: shadow.y
        )
    }

    /// Применить большую тень
    func shadowLarge() -> some View {
        let shadow = AppDesignTokens.Shadow.large
        return self.shadow(
            color: shadow.color,
            radius: shadow.radius,
            x: shadow.x,
            y: shadow.y
        )
    }
}
