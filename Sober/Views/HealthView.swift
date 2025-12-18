import SwiftUI

struct HealthView: View {
    @EnvironmentObject var viewModel: SobrietyViewModel

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    if let data = viewModel.sobrietyData {
                        // Progress Overview
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Ваш прогресс")
                                .font(.headline)

                            let achievedCount = viewModel.getAchievedMilestones().count
                            let totalCount = HealthMilestone.milestones.count

                            ProgressView(value: Double(achievedCount), total: Double(totalCount))
                                .tint(.green)

                            Text("\(achievedCount) из \(totalCount) этапов достигнуто")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                        .padding(.horizontal)

                        // Achieved Milestones
                        let achieved = viewModel.getAchievedMilestones()
                        if !achieved.isEmpty {
                            VStack(alignment: .leading, spacing: 12) {
                                Text("Пройденные этапы")
                                    .font(.headline)
                                    .padding(.horizontal)

                                ForEach(achieved) { milestone in
                                    HealthMilestoneCard(milestone: milestone, isAchieved: true, daysSober: data.daysSober)
                                        .padding(.horizontal)
                                }
                            }
                        }

                        // Next Milestone
                        if let nextMilestone = viewModel.getNextMilestone() {
                            VStack(alignment: .leading, spacing: 12) {
                                Text("Следующий этап")
                                    .font(.headline)
                                    .padding(.horizontal)

                                HealthMilestoneCard(milestone: nextMilestone, isAchieved: false, daysSober: data.daysSober)
                                    .padding(.horizontal)
                            }
                        }

                        // Upcoming Milestones
                        let upcoming = HealthMilestone.milestones.filter {
                            !$0.isAchieved(daysSober: data.daysSober) && $0.id != viewModel.getNextMilestone()?.id
                        }

                        if !upcoming.isEmpty {
                            VStack(alignment: .leading, spacing: 12) {
                                Text("Предстоящие этапы")
                                    .font(.headline)
                                    .padding(.horizontal)

                                ForEach(upcoming) { milestone in
                                    HealthMilestoneCard(milestone: milestone, isAchieved: false, daysSober: data.daysSober)
                                        .padding(.horizontal)
                                }
                            }
                        }
                    }
                }
                .padding(.vertical)
            }
            .navigationTitle("Здоровье")
        }
    }
}

struct HealthMilestoneCard: View {
    let milestone: HealthMilestone
    let isAchieved: Bool
    let daysSober: Int

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: milestone.icon)
                .font(.title2)
                .foregroundColor(isAchieved ? .green : .gray)
                .frame(width: 40)

            VStack(alignment: .leading, spacing: 4) {
                Text(milestone.title)
                    .font(.headline)
                    .foregroundColor(isAchieved ? .primary : .secondary)

                Text(milestone.description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .fixedSize(horizontal: false, vertical: true)

                if !isAchieved {
                    Text("Осталось \(milestone.daysRequired - daysSober) дней")
                        .font(.caption)
                        .foregroundColor(.blue)
                        .padding(.top, 4)
                }
            }

            Spacer()

            if isAchieved {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.green)
                    .font(.title3)
            }
        }
        .padding()
        .background(isAchieved ? Color.green.opacity(0.1) : Color(.systemGray6))
        .cornerRadius(12)
    }
}
