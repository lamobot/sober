import SwiftUI

struct AchievementsView: View {
    @EnvironmentObject var viewModel: SobrietyViewModel

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    if let data = viewModel.sobrietyData {
                        // Progress Summary
                        let unlocked = viewModel.getUnlockedAchievements()
                        let total = Achievement.achievements.count

                        VStack(spacing: 12) {
                            Text("Разблокировано")
                                .font(.headline)

                            ZStack {
                                Circle()
                                    .stroke(Color.gray.opacity(0.3), lineWidth: 12)
                                    .frame(width: 120, height: 120)

                                Circle()
                                    .trim(from: 0, to: CGFloat(unlocked.count) / CGFloat(total))
                                    .stroke(Color.yellow, style: StrokeStyle(lineWidth: 12, lineCap: .round))
                                    .frame(width: 120, height: 120)
                                    .rotationEffect(.degrees(-90))

                                VStack(spacing: 4) {
                                    Text("\(unlocked.count)")
                                        .font(.system(size: 36, weight: .bold))
                                    Text("из \(total)")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                            }
                        }
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(16)
                        .padding(.horizontal)

                        // Unlocked Achievements
                        if !unlocked.isEmpty {
                            VStack(alignment: .leading, spacing: 12) {
                                Text("Разблокированные достижения")
                                    .font(.headline)
                                    .padding(.horizontal)

                                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                                    ForEach(unlocked) { achievement in
                                        AchievementCard(achievement: achievement, isUnlocked: true)
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }

                        // Locked Achievements
                        let locked = viewModel.getLockedAchievements()
                        if !locked.isEmpty {
                            VStack(alignment: .leading, spacing: 12) {
                                Text("Заблокированные достижения")
                                    .font(.headline)
                                    .padding(.horizontal)

                                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                                    ForEach(locked) { achievement in
                                        AchievementCard(achievement: achievement, isUnlocked: false, daysSober: data.daysSober)
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                    }
                }
                .padding(.vertical)
            }
            .navigationTitle("Достижения")
        }
    }
}

struct AchievementCard: View {
    let achievement: Achievement
    let isUnlocked: Bool
    var daysSober: Int = 0

    private var color: Color {
        switch achievement.color {
        case "blue": return .blue
        case "green": return .green
        case "purple": return .purple
        case "orange": return .orange
        case "yellow": return .yellow
        case "red": return .red
        case "cyan": return .cyan
        case "pink": return .pink
        case "gold": return .yellow
        case "silver": return .gray
        default: return .gray
        }
    }

    var body: some View {
        VStack(spacing: 12) {
            ZStack {
                Circle()
                    .fill(isUnlocked ? color.opacity(0.2) : Color.gray.opacity(0.1))
                    .frame(width: 80, height: 80)

                Image(systemName: achievement.badgeIcon)
                    .font(.system(size: 40))
                    .foregroundColor(isUnlocked ? color : .gray)
            }

            VStack(spacing: 4) {
                Text(achievement.title)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                    .foregroundColor(isUnlocked ? .primary : .secondary)

                if !isUnlocked && daysSober > 0 {
                    Text("Через \(achievement.daysRequired - daysSober) дней")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(isUnlocked ? color.opacity(0.1) : Color(.systemGray6))
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(isUnlocked ? color : Color.clear, lineWidth: 2)
        )
        .opacity(isUnlocked ? 1.0 : 0.6)
    }
}
