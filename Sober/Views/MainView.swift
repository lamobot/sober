import SwiftUI

struct MainView: View {
    @EnvironmentObject var viewModel: SobrietyViewModel

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: AppSpacing.xl) {
                    if let data = viewModel.sobrietyData {
                        // Hero Section with Gradient
                        VStack(spacing: AppSpacing.sm) {
                            Text(NSLocalizedString("main.sober_since", comment: ""))
                                .font(AppTypography.labelMedium)
                                .foregroundColor(AppColor.textSecondary)

                            Text(data.sobrietyStartDate, style: .date)
                                .font(AppTypography.labelLarge)

                            // Animated Counter
                            VStack(spacing: AppSpacing.xxs) {
                                AnimatedCounter(
                                    value: data.displayTimeValue,
                                    font: AppTypography.displayLarge
                                )
                                .foregroundColor(AppColor.textPrimary)

                                Text(data.displayTimeUnit())
                                    .font(AppTypography.headlineMedium)
                                    .foregroundColor(AppColor.textSecondary)
                            }
                            .padding()
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            LinearGradient(
                                colors: [
                                    AppColor.primary.opacity(0.1),
                                    AppColor.primary.opacity(0.05)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .cornerRadius(AppDesignTokens.CornerRadius.large)
                        .padding(.horizontal)

                        // Stats Grid with Animations
                        VStack(spacing: AppSpacing.md) {
                            StatCard(
                                title: NSLocalizedString("main.money_saved", comment: ""),
                                value: String(format: "%.0f €", data.moneySaved),
                                icon: "eurosign.circle.fill",
                                color: AppColor.money
                            )
                            .slideIn(from: .leading, delay: 0.1)

                            StatCard(
                                title: NSLocalizedString("main.time_saved", comment: ""),
                                value: String(format: "%.1f %@", data.timeSaved, NSLocalizedString("currency.days", comment: "")),
                                icon: "clock.fill",
                                color: AppColor.time
                            )
                            .slideIn(from: .leading, delay: 0.2)

                            StatCard(
                                title: NSLocalizedString("main.days_streak", comment: ""),
                                value: "\(data.daysSober)",
                                icon: "calendar",
                                color: AppColor.days
                            )
                            .slideIn(from: .leading, delay: 0.3)
                        }
                        .padding(.horizontal)

                        // Projections
                        VStack(alignment: .leading, spacing: AppSpacing.sm) {
                            Text(NSLocalizedString("main.projections", comment: ""))
                                .font(AppTypography.labelLarge)
                                .padding(.horizontal)

                            HStack(spacing: AppSpacing.sm) {
                                ProjectionCard(
                                    period: NSLocalizedString("main.projection_6months", comment: ""),
                                    amount: String(format: "%.0f €", data.projectedSavings6Months)
                                )

                                ProjectionCard(
                                    period: NSLocalizedString("main.projection_12months", comment: ""),
                                    amount: String(format: "%.0f €", data.projectedSavings12Months)
                                )
                            }
                            .padding(.horizontal)
                        }
                        .padding(.vertical)
                        .slideIn(from: .bottom, delay: 0.4)

                        // Next Milestone with Pulse
                        if let nextMilestone = viewModel.getNextMilestone() {
                            VStack(alignment: .leading, spacing: AppSpacing.xs) {
                                Text(NSLocalizedString("main.next_milestone", comment: ""))
                                    .font(AppTypography.labelLarge)

                                HStack(spacing: AppSpacing.md) {
                                    Image(systemName: nextMilestone.icon)
                                        .font(.system(size: AppDesignTokens.IconSize.large))
                                        .foregroundColor(AppColor.milestone)
                                        .pulse()

                                    VStack(alignment: .leading, spacing: AppSpacing.xxs) {
                                        Text(nextMilestone.title)
                                            .font(AppTypography.labelMedium)
                                            .fontWeight(.semibold)

                                        Text(String(format: NSLocalizedString("main.days_remaining", comment: ""), nextMilestone.daysRequired - data.daysSober))
                                            .font(AppTypography.labelSmall)
                                            .foregroundColor(AppColor.textSecondary)
                                    }

                                    Spacer()
                                }
                                .padding(AppSpacing.cardInner)
                                .background(AppColor.milestone.lightBackground)
                                .cornerRadius(AppDesignTokens.CornerRadius.medium)
                                .overlay(
                                    RoundedRectangle(cornerRadius: AppDesignTokens.CornerRadius.medium)
                                        .stroke(AppColor.milestone.opacity(0.3), lineWidth: 1)
                                )
                            }
                            .padding(.horizontal)
                            .slideIn(from: .bottom, delay: 0.5)
                        }
                    }
                }
                .padding(.vertical)
            }
            .navigationTitle("Sober")
        }
    }
}

struct StatCard: View {
    let title: String
    let value: String
    let icon: String
    let color: Color

    var body: some View {
        HStack(spacing: AppSpacing.md) {
            Image(systemName: icon)
                .font(.system(size: AppDesignTokens.IconSize.xlarge))
                .foregroundColor(color)
                .frame(width: AppDesignTokens.FrameSize.iconMedium)

            VStack(alignment: .leading, spacing: AppSpacing.xxs) {
                Text(title)
                    .font(AppTypography.labelMedium)
                    .foregroundColor(AppColor.textSecondary)

                Text(value)
                    .font(AppTypography.headlineMedium)
                    .fontWeight(.bold)
                    .foregroundColor(AppColor.textPrimary)
            }

            Spacer()
        }
        .padding(AppSpacing.cardInner)
        .background(AppColor.backgroundSecondary)
        .cornerRadius(AppDesignTokens.CornerRadius.medium)
        .shadowSmall()
    }
}

struct ProjectionCard: View {
    let period: String
    let amount: String

    var body: some View {
        VStack(alignment: .leading, spacing: AppSpacing.xs) {
            Text(period)
                .font(AppTypography.labelSmall)
                .foregroundColor(AppColor.textSecondary)

            Text(amount)
                .font(AppTypography.headlineSmall)
                .fontWeight(.bold)
                .foregroundColor(AppColor.textPrimary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(AppSpacing.cardInner)
        .background(AppColor.backgroundSecondary)
        .cornerRadius(AppDesignTokens.CornerRadius.medium)
        .shadowSmall()
    }
}
