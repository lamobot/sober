import SwiftUI

// MARK: - Primary Button Style

/// Основной стиль кнопки (заполненная)
struct PrimaryButtonStyle: ButtonStyle {
    var color: Color = AppColor.primary
    var isDisabled: Bool = false

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(AppTypography.labelLarge)
            .fontWeight(.semibold)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding(.vertical, AppSpacing.md)
            .background(isDisabled ? AppColor.textTertiary : color)
            .cornerRadius(AppDesignTokens.CornerRadius.medium)
            .scaleEffect(configuration.isPressed ? 0.97 : 1.0)
            .animation(.easeInOut(duration: AppDesignTokens.AnimationDuration.fast), value: configuration.isPressed)
            .opacity(isDisabled ? AppColor.Opacity.disabled : AppColor.Opacity.opaque)
    }
}

// MARK: - Secondary Button Style

/// Вторичный стиль кнопки (обводка)
struct SecondaryButtonStyle: ButtonStyle {
    var color: Color = AppColor.primary
    var isDisabled: Bool = false

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(AppTypography.labelLarge)
            .fontWeight(.semibold)
            .foregroundColor(isDisabled ? AppColor.textTertiary : color)
            .frame(maxWidth: .infinity)
            .padding(.vertical, AppSpacing.md)
            .background(Color.clear)
            .overlay(
                RoundedRectangle(cornerRadius: AppDesignTokens.CornerRadius.medium)
                    .stroke(isDisabled ? AppColor.textTertiary : color, lineWidth: AppDesignTokens.BorderWidth.medium)
            )
            .scaleEffect(configuration.isPressed ? 0.97 : 1.0)
            .animation(.easeInOut(duration: AppDesignTokens.AnimationDuration.fast), value: configuration.isPressed)
            .opacity(isDisabled ? AppColor.Opacity.disabled : AppColor.Opacity.opaque)
    }
}

// MARK: - Tertiary Button Style

/// Третичный стиль кнопки (только текст)
struct TertiaryButtonStyle: ButtonStyle {
    var color: Color = AppColor.primary

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(AppTypography.labelMedium)
            .fontWeight(.medium)
            .foregroundColor(color)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.easeInOut(duration: AppDesignTokens.AnimationDuration.fast), value: configuration.isPressed)
            .opacity(configuration.isPressed ? 0.7 : 1.0)
    }
}

// MARK: - Icon Button Style

/// Стиль кнопки-иконки (круглая)
struct IconButtonStyle: ButtonStyle {
    var color: Color = AppColor.primary
    var size: CGFloat = AppDesignTokens.FrameSize.iconSmall

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: AppDesignTokens.IconSize.medium))
            .foregroundColor(color)
            .frame(width: size, height: size)
            .background(color.lightBackground)
            .clipShape(Circle())
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
            .animation(.spring(response: 0.3, dampingFraction: 0.6), value: configuration.isPressed)
    }
}

// MARK: - Destructive Button Style

/// Стиль деструктивной кнопки (удаление, сброс)
struct DestructiveButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(AppTypography.labelLarge)
            .fontWeight(.semibold)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding(.vertical, AppSpacing.md)
            .background(AppColor.danger)
            .cornerRadius(AppDesignTokens.CornerRadius.medium)
            .scaleEffect(configuration.isPressed ? 0.97 : 1.0)
            .animation(.easeInOut(duration: AppDesignTokens.AnimationDuration.fast), value: configuration.isPressed)
    }
}

// MARK: - View Extensions

extension View {
    /// Применить стиль primary кнопки
    func primaryButton(color: Color = AppColor.primary, isDisabled: Bool = false) -> some View {
        self.buttonStyle(PrimaryButtonStyle(color: color, isDisabled: isDisabled))
    }

    /// Применить стиль secondary кнопки
    func secondaryButton(color: Color = AppColor.primary, isDisabled: Bool = false) -> some View {
        self.buttonStyle(SecondaryButtonStyle(color: color, isDisabled: isDisabled))
    }

    /// Применить стиль tertiary кнопки
    func tertiaryButton(color: Color = AppColor.primary) -> some View {
        self.buttonStyle(TertiaryButtonStyle(color: color))
    }

    /// Применить стиль icon кнопки
    func iconButton(color: Color = AppColor.primary, size: CGFloat = AppDesignTokens.FrameSize.iconSmall) -> some View {
        self.buttonStyle(IconButtonStyle(color: color, size: size))
    }

    /// Применить стиль destructive кнопки
    func destructiveButton() -> some View {
        self.buttonStyle(DestructiveButtonStyle())
    }
}

// MARK: - Preview Helper Buttons

#Preview("Button Styles") {
    VStack(spacing: AppSpacing.lg) {
        Button("Primary Button") {}
            .primaryButton()

        Button("Secondary Button") {}
            .secondaryButton()

        Button("Tertiary Button") {}
            .tertiaryButton()

        Button("Disabled Primary") {}
            .primaryButton(isDisabled: true)

        Button("Destructive Button") {}
            .destructiveButton()

        HStack(spacing: AppSpacing.md) {
            Button {
            } label: {
                Image(systemName: "plus")
            }
            .iconButton()

            Button {
            } label: {
                Image(systemName: "heart.fill")
            }
            .iconButton(color: AppColor.danger)
        }
    }
    .padding()
}
