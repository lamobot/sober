import SwiftUI

// MARK: - Animated Progress Ring

/// Анимированное кольцо прогресса
struct AnimatedProgressRing: View {
    let progress: Double // 0.0 - 1.0
    let lineWidth: CGFloat
    let color: Color
    let size: CGFloat

    @State private var animatedProgress: Double = 0

    var body: some View {
        ZStack {
            // Background circle
            Circle()
                .stroke(AppColor.backgroundSecondary, lineWidth: lineWidth)

            // Progress circle
            Circle()
                .trim(from: 0, to: animatedProgress)
                .stroke(
                    color,
                    style: StrokeStyle(
                        lineWidth: lineWidth,
                        lineCap: .round
                    )
                )
                .rotationEffect(.degrees(-90))
                .animation(
                    .spring(response: 1.0, dampingFraction: 0.8),
                    value: animatedProgress
                )
        }
        .frame(width: size, height: size)
        .onAppear {
            animatedProgress = progress
        }
        .onChange(of: progress) { newValue in
            animatedProgress = newValue
        }
    }
}

// MARK: - Animated Counter

/// Анимированный счетчик с эффектом подсчета
struct AnimatedCounter: View {
    let value: Int
    let font: Font

    @State private var currentValue: Int = 0

    var body: some View {
        Text("\(currentValue)")
            .font(font)
            .contentTransition(.numericText())
            .onAppear {
                // Мгновенно показать значение, затем анимировать
                if currentValue == 0 {
                    currentValue = value
                }
                animateCounter()
            }
            .onChange(of: value) { _ in
                animateCounter()
            }
    }

    private func animateCounter() {
        guard value != currentValue else { return }

        withAnimation(.easeOut(duration: 0.8)) {
            currentValue = value
        }
    }
}

// MARK: - Shimmer Effect

/// Эффект мерцания (для скелетонов загрузки)
struct ShimmerEffect: ViewModifier {
    @State private var phase: CGFloat = 0

    func body(content: Content) -> some View {
        content
            .overlay(
                LinearGradient(
                    colors: [
                        .clear,
                        .white.opacity(0.3),
                        .clear
                    ],
                    startPoint: .leading,
                    endPoint: .trailing
                )
                .offset(x: phase)
                .mask(content)
            )
            .onAppear {
                withAnimation(
                    .linear(duration: 1.5)
                    .repeatForever(autoreverses: false)
                ) {
                    phase = 300
                }
            }
    }
}

// MARK: - Bounce Animation

/// Анимация подпрыгивания при появлении
struct BounceAnimation: ViewModifier {
    @State private var isVisible = false
    let delay: Double

    func body(content: Content) -> some View {
        content
            .scaleEffect(isVisible ? 1.0 : 0.5)
            .opacity(isVisible ? 1.0 : 0.0)
            .onAppear {
                withAnimation(
                    .spring(response: 0.6, dampingFraction: 0.6)
                    .delay(delay)
                ) {
                    isVisible = true
                }
            }
    }
}

// MARK: - Slide In Animation

/// Анимация появления сбоку
struct SlideInAnimation: ViewModifier {
    @State private var isVisible = false
    let delay: Double
    let edge: Edge

    func body(content: Content) -> some View {
        content
            .offset(x: isVisible ? 0 : offsetValue)
            .opacity(isVisible ? 1.0 : 0.0)
            .onAppear {
                withAnimation(
                    .easeOut(duration: AppDesignTokens.AnimationDuration.medium)
                    .delay(delay)
                ) {
                    isVisible = true
                }
            }
    }

    private var offsetValue: CGFloat {
        switch edge {
        case .leading: return -100
        case .trailing: return 100
        case .top: return -100
        case .bottom: return 100
        }
    }
}

// MARK: - Pulse Animation

/// Эффект пульсации
struct PulseAnimation: ViewModifier {
    @State private var isPulsing = false

    func body(content: Content) -> some View {
        content
            .scaleEffect(isPulsing ? 1.05 : 1.0)
            .animation(
                .easeInOut(duration: 1.0)
                .repeatForever(autoreverses: true),
                value: isPulsing
            )
            .onAppear {
                isPulsing = true
            }
    }
}

// MARK: - Celebration Animation

/// Анимация празднования (для достижений)
struct CelebrationAnimation: ViewModifier {
    @State private var scale: CGFloat = 0.5
    @State private var rotation: Double = 0
    @State private var opacity: Double = 0

    func body(content: Content) -> some View {
        content
            .scaleEffect(scale)
            .rotationEffect(.degrees(rotation))
            .opacity(opacity)
            .onAppear {
                withAnimation(.spring(response: 0.8, dampingFraction: 0.5)) {
                    scale = 1.0
                    opacity = 1.0
                }
                withAnimation(.easeOut(duration: 0.6)) {
                    rotation = 360
                }
            }
    }
}

// MARK: - View Extensions

extension View {
    /// Добавить эффект shimmer
    func shimmer() -> some View {
        self.modifier(ShimmerEffect())
    }

    /// Добавить bounce анимацию
    func bounce(delay: Double = 0) -> some View {
        self.modifier(BounceAnimation(delay: delay))
    }

    /// Добавить slide-in анимацию
    func slideIn(from edge: Edge = .leading, delay: Double = 0) -> some View {
        self.modifier(SlideInAnimation(delay: delay, edge: edge))
    }

    /// Добавить pulse анимацию
    func pulse() -> some View {
        self.modifier(PulseAnimation())
    }

    /// Добавить celebration анимацию
    func celebrate() -> some View {
        self.modifier(CelebrationAnimation())
    }
}

// MARK: - Achievement Badge с анимацией

/// Анимированный badge достижения
struct AnimatedAchievementBadge: View {
    let icon: String
    let color: Color
    let isUnlocked: Bool
    let size: CGFloat

    var body: some View {
        let badge = ZStack {
            Circle()
                .fill(isUnlocked ? color.lightBackground : AppColor.backgroundSecondary)
                .frame(width: size, height: size)

            Image(systemName: icon)
                .font(.system(size: size * 0.5))
                .foregroundColor(isUnlocked ? color : AppColor.textTertiary)
        }
        .overlay(
            Circle()
                .stroke(isUnlocked ? color : Color.clear, lineWidth: AppDesignTokens.BorderWidth.medium)
        )
        .opacity(isUnlocked ? AppColor.Opacity.opaque : AppColor.Opacity.disabled)

        if isUnlocked {
            return AnyView(badge.celebrate())
        } else {
            return AnyView(badge)
        }
    }
}

// MARK: - Previews

#Preview("Animated Components") {
    VStack(spacing: AppSpacing.xl) {
        AnimatedProgressRing(
            progress: 0.75,
            lineWidth: 12,
            color: AppColor.success,
            size: AppDesignTokens.FrameSize.progressCircleLarge
        )

        AnimatedCounter(value: 365, font: AppTypography.displayMedium)

        AnimatedAchievementBadge(
            icon: "star.fill",
            color: AppColor.Badge.gold,
            isUnlocked: true,
            size: AppDesignTokens.FrameSize.badge
        )

        Text("Slide In")
            .slideIn(from: .leading, delay: 0.2)

        Text("Bounce")
            .bounce(delay: 0.4)
    }
    .padding()
}
