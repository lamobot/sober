import SwiftUI

struct AchievementsView: View {
    @EnvironmentObject var viewModel: SobrietyViewModel

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: AppSpacing.lg) {
                    if let data = viewModel.sobrietyData {
                        // Progress Summary with Animated Ring
                        let unlocked = viewModel.getUnlockedAchievements()
                        let total = Achievement.achievements.count
                        let progress = Double(unlocked.count) / Double(total)

                        VStack(spacing: AppSpacing.sm) {
                            Text(NSLocalizedString("achievements.unlocked", comment: ""))
                                .font(AppTypography.labelLarge)

                            ZStack {
                                AnimatedProgressRing(
                                    progress: progress,
                                    lineWidth: 12,
                                    color: AppColor.Badge.gold,
                                    size: AppDesignTokens.FrameSize.progressCircle
                                )

                                VStack(spacing: AppSpacing.xxs) {
                                    AnimatedCounter(
                                        value: unlocked.count,
                                        font: AppTypography.counterLarge
                                    )
                                    .foregroundColor(AppColor.textPrimary)

                                    Text(String(format: "/ %d", total))
                                        .font(AppTypography.labelSmall)
                                        .foregroundColor(AppColor.textSecondary)
                                }
                            }
                        }
                        .padding(AppSpacing.cardInner)
                        .background(AppColor.backgroundSecondary)
                        .cornerRadius(AppDesignTokens.CornerRadius.large)
                        .shadowMedium()
                        .padding(.horizontal)

                        // Unlocked Achievements
                        if !unlocked.isEmpty {
                            VStack(alignment: .leading, spacing: AppSpacing.sm) {
                                Text(NSLocalizedString("achievements.unlocked_section", comment: ""))
                                    .font(AppTypography.labelLarge)
                                    .padding(.horizontal)

                                LazyVGrid(
                                    columns: AppDesignTokens.Grid.twoColumns,
                                    spacing: AppSpacing.md
                                ) {
                                    ForEach(Array(unlocked.enumerated()), id: \.element.id) { index, achievement in
                                        AchievementCard(
                                            achievement: achievement,
                                            isUnlocked: true
                                        )
                                        .bounce(delay: Double(index) * 0.1)
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }

                        // Locked Achievements
                        let locked = viewModel.getLockedAchievements()
                        if !locked.isEmpty {
                            VStack(alignment: .leading, spacing: AppSpacing.sm) {
                                Text(NSLocalizedString("achievements.locked_section", comment: ""))
                                    .font(AppTypography.labelLarge)
                                    .padding(.horizontal)

                                LazyVGrid(
                                    columns: AppDesignTokens.Grid.twoColumns,
                                    spacing: AppSpacing.md
                                ) {
                                    ForEach(locked) { achievement in
                                        AchievementCard(
                                            achievement: achievement,
                                            isUnlocked: false,
                                            daysSober: data.daysSober
                                        )
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                    }
                }
                .padding(.vertical)
            }
            .navigationTitle(NSLocalizedString("achievements.title", comment: ""))
        }
    }
}

struct AchievementCard: View {
    let achievement: Achievement
    let isUnlocked: Bool
    var daysSober: Int = 0

    private var color: Color {
        AppColor.Badge.color(for: achievement.color)
    }

    var body: some View {
        VStack(spacing: AppSpacing.sm) {
            // Animated Badge
            AnimatedAchievementBadge(
                icon: achievement.badgeIcon,
                color: color,
                isUnlocked: isUnlocked,
                size: AppDesignTokens.FrameSize.badge
            )

            VStack(spacing: AppSpacing.xxs) {
                Text(achievement.title)
                    .font(AppTypography.labelMedium)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                    .foregroundColor(isUnlocked ? AppColor.textPrimary : AppColor.textSecondary)

                if !isUnlocked && daysSober > 0 {
                    Text(String(format: NSLocalizedString("achievements.days_remaining", comment: ""), achievement.daysRequired - daysSober))
                        .font(AppTypography.labelSmall)
                        .foregroundColor(AppColor.textSecondary)
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding(AppSpacing.cardInner)
        .background(
            isUnlocked ? color.lightBackground : AppColor.backgroundSecondary
        )
        .cornerRadius(AppDesignTokens.CornerRadius.large)
        .overlay(
            RoundedRectangle(cornerRadius: AppDesignTokens.CornerRadius.large)
                .stroke(
                    isUnlocked ? color.opacity(0.5) : Color.clear,
                    lineWidth: AppDesignTokens.BorderWidth.medium
                )
        )
        .opacity(isUnlocked ? AppColor.Opacity.opaque : AppColor.Opacity.disabled)
    }
}
