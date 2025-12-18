import SwiftUI

struct MainView: View {
    @EnvironmentObject var viewModel: SobrietyViewModel

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    if let data = viewModel.sobrietyData {
                        // Hero Section
                        VStack(spacing: 12) {
                            Text("Вы не употребляете алкоголь с")
                                .font(.subheadline)
                                .foregroundColor(.secondary)

                            Text(data.sobrietyStartDate, style: .date)
                                .font(.headline)

                            // Main Counter
                            VStack(spacing: 4) {
                                Text("\(data.displayTimeValue)")
                                    .font(.system(size: 72, weight: .bold, design: .rounded))
                                    .foregroundColor(.primary)

                                Text(data.displayTimeUnit)
                                    .font(.title2)
                                    .foregroundColor(.secondary)
                            }
                            .padding()
                        }
                        .padding()

                        // Stats Grid
                        VStack(spacing: 16) {
                            StatCard(
                                title: "Сэкономлено денег",
                                value: String(format: "%.0f €", data.moneySaved),
                                icon: "eurosign.circle.fill",
                                color: .green
                            )

                            StatCard(
                                title: "Сэкономлено времени",
                                value: String(format: "%.1f дней", data.timeSaved),
                                icon: "clock.fill",
                                color: .blue
                            )

                            StatCard(
                                title: "Дней подряд",
                                value: "\(data.daysSober)",
                                icon: "calendar",
                                color: .orange
                            )
                        }
                        .padding(.horizontal)

                        // Projections
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Прогноз экономии")
                                .font(.headline)
                                .padding(.horizontal)

                            HStack(spacing: 12) {
                                ProjectionCard(
                                    period: "Через 6 месяцев",
                                    amount: String(format: "%.0f €", data.projectedSavings6Months)
                                )

                                ProjectionCard(
                                    period: "Через 12 месяцев",
                                    amount: String(format: "%.0f €", data.projectedSavings12Months)
                                )
                            }
                            .padding(.horizontal)
                        }
                        .padding(.vertical)

                        // Next Milestone
                        if let nextMilestone = viewModel.getNextMilestone() {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Следующая цель")
                                    .font(.headline)

                                HStack {
                                    Image(systemName: nextMilestone.icon)
                                        .font(.title2)
                                        .foregroundColor(.purple)

                                    VStack(alignment: .leading) {
                                        Text(nextMilestone.title)
                                            .font(.subheadline)
                                            .fontWeight(.semibold)

                                        Text("Осталось \(nextMilestone.daysRequired - data.daysSober) дней")
                                            .font(.caption)
                                            .foregroundColor(.secondary)
                                    }

                                    Spacer()
                                }
                                .padding()
                                .background(Color(.systemGray6))
                                .cornerRadius(12)
                            }
                            .padding(.horizontal)
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
        HStack {
            Image(systemName: icon)
                .font(.title)
                .foregroundColor(color)
                .frame(width: 50)

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                Text(value)
                    .font(.title2)
                    .fontWeight(.bold)
            }

            Spacer()
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}

struct ProjectionCard: View {
    let period: String
    let amount: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(period)
                .font(.caption)
                .foregroundColor(.secondary)

            Text(amount)
                .font(.title3)
                .fontWeight(.bold)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}
