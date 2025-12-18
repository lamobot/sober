import SwiftUI

/// Централизованная система отступов и spacing
enum AppSpacing {
    // MARK: - Padding Values

    /// Очень маленький отступ (4pt)
    static let xxs: CGFloat = 4

    /// Маленький отступ (8pt)
    static let xs: CGFloat = 8

    /// Средний отступ (12pt)
    static let sm: CGFloat = 12

    /// Стандартный отступ (16pt)
    static let md: CGFloat = 16

    /// Большой отступ (20pt)
    static let lg: CGFloat = 20

    /// Очень большой отступ (24pt)
    static let xl: CGFloat = 24

    /// Огромный отступ (32pt)
    static let xxl: CGFloat = 32

    /// Максимальный отступ (40pt)
    static let xxxl: CGFloat = 40

    // MARK: - Semantic Spacing

    /// Отступ внутри карточки
    static let cardInner = md

    /// Отступ между карточками
    static let cardOuter = md

    /// Отступ между секциями
    static let section = xl

    /// Отступ от краёв экрана
    static let screen = md

    /// Отступ между элементами в списке
    static let listItem = xs

    /// Отступ между элементами в форме
    static let formItem = lg
}

// MARK: - View Extensions

extension View {
    /// Добавить стандартный padding для карточки
    func cardPadding() -> some View {
        self.padding(AppSpacing.cardInner)
    }

    /// Добавить горизонтальный padding для экрана
    func screenPadding() -> some View {
        self.padding(.horizontal, AppSpacing.screen)
    }

    /// Добавить вертикальный padding для секции
    func sectionPadding() -> some View {
        self.padding(.vertical, AppSpacing.section)
    }

    /// Добавить кастомный spacing
    func spacing(_ value: CGFloat) -> some View {
        self.padding(value)
    }
}

// MARK: - Layout Helpers

extension AppSpacing {
    /// Создать VStack с заданным spacing
    static func vStack<Content: View>(
        spacing: CGFloat = md,
        alignment: HorizontalAlignment = .leading,
        @ViewBuilder content: () -> Content
    ) -> some View {
        VStack(alignment: alignment, spacing: spacing, content: content)
    }

    /// Создать HStack с заданным spacing
    static func hStack<Content: View>(
        spacing: CGFloat = md,
        alignment: VerticalAlignment = .center,
        @ViewBuilder content: () -> Content
    ) -> some View {
        HStack(alignment: alignment, spacing: spacing, content: content)
    }
}
