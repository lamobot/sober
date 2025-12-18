import SwiftUI

// MARK: - Card View Modifier

/// Базовый стиль карточки
struct CardStyle: ViewModifier {
    var backgroundColor: Color = AppColor.backgroundSecondary
    var cornerRadius: CGFloat = AppDesignTokens.CornerRadius.medium
    var shadow: Bool = false

    func body(content: Content) -> some View {
        let baseCard = content
            .padding(AppSpacing.cardInner)
            .background(backgroundColor)
            .cornerRadius(cornerRadius)

        if shadow {
            return AnyView(baseCard.shadowSmall())
        } else {
            return AnyView(baseCard)
        }
    }
}

/// Стиль карточки с акцентом (цветной фон)
struct AccentCardStyle: ViewModifier {
    var color: Color
    var isActive: Bool = true

    func body(content: Content) -> some View {
        content
            .padding(AppSpacing.cardInner)
            .background(isActive ? color.lightBackground : AppColor.backgroundSecondary)
            .cornerRadius(AppDesignTokens.CornerRadius.medium)
            .overlay(
                RoundedRectangle(cornerRadius: AppDesignTokens.CornerRadius.medium)
                    .stroke(isActive ? color : Color.clear, lineWidth: AppDesignTokens.BorderWidth.medium)
            )
            .opacity(isActive ? AppColor.Opacity.opaque : AppColor.Opacity.disabled)
    }
}

/// Стиль карточки со статом (иконка + заголовок + значение)
struct StatCardStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(AppSpacing.cardInner)
            .background(AppColor.backgroundSecondary)
            .cornerRadius(AppDesignTokens.CornerRadius.medium)
    }
}

// MARK: - View Extensions

extension View {
    /// Применить базовый стиль карточки
    func cardStyle(
        backgroundColor: Color = AppColor.backgroundSecondary,
        cornerRadius: CGFloat = AppDesignTokens.CornerRadius.medium,
        shadow: Bool = false
    ) -> some View {
        self.modifier(CardStyle(
            backgroundColor: backgroundColor,
            cornerRadius: cornerRadius,
            shadow: shadow
        ))
    }

    /// Применить стиль акцентной карточки
    func accentCard(color: Color, isActive: Bool = true) -> some View {
        self.modifier(AccentCardStyle(color: color, isActive: isActive))
    }

    /// Применить стиль stat карточки
    func statCard() -> some View {
        self.modifier(StatCardStyle())
    }
}
