import SwiftUI

struct MainView: View {
    @EnvironmentObject var viewModel: SobrietyViewModel

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: AppSpacing.xl) {
                    if let data = viewModel.sobrietyData {
                        // Hero Section - Main Counter
                        VStack(spacing: AppSpacing.md) {
                            Text(NSLocalizedString("main.sober_since", comment: ""))
                                .font(AppTypography.labelMedium)
                                .foregroundColor(AppColor.textSecondary)

                            Text(data.sobrietyStartDate, style: .date)
                                .font(AppTypography.labelLarge)
                                .foregroundColor(AppColor.textPrimary)

                            Spacer().frame(height: AppSpacing.sm)

                            // Main Counter - Days Sober
                            VStack(spacing: AppSpacing.xs) {
                                AnimatedCounter(
                                    value: data.daysSober,
                                    font: AppTypography.displayLarge
                                )
                                .foregroundColor(AppColor.primary)

                                Text(data.daysSober == 1 ?
                                     NSLocalizedString("time.day", comment: "") :
                                     NSLocalizedString("time.days", comment: ""))
                                    .font(AppTypography.headlineMedium)
                                    .foregroundColor(AppColor.textSecondary)
                            }

                            Spacer().frame(height: AppSpacing.xs)

                            // Alternative time representation
                            if data.yearsSober >= 1 {
                                Text(String(format: NSLocalizedString("main.also_years", comment: ""),
                                          data.yearsSober,
                                          data.monthsSober % 12))
                                    .font(AppTypography.labelMedium)
                                    .foregroundColor(AppColor.textTertiary)
                            } else if data.monthsSober >= 1 {
                                Text(String(format: NSLocalizedString("main.also_months", comment: ""),
                                          data.monthsSober,
                                          data.weeksSober % 4))
                                    .font(AppTypography.labelMedium)
                                    .foregroundColor(AppColor.textTertiary)
                            } else if data.weeksSober >= 1 {
                                Text(String(format: NSLocalizedString("main.also_weeks", comment: ""),
                                          data.weeksSober))
                                    .font(AppTypography.labelMedium)
                                    .foregroundColor(AppColor.textTertiary)
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .padding(AppSpacing.lg)
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
                        .shadowMedium()
                        .padding(.horizontal)

                        // Stats Grid - Money & Time
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
                        .slideIn(from: .bottom, delay: 0.3)

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
                            .slideIn(from: .bottom, delay: 0.4)
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
