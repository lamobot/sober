import Foundation
import Combine

class SobrietyViewModel: ObservableObject {
    @Published var sobrietyData: SobrietyData?
    @Published var settings: Settings = Settings()
    @Published var moodEntries: [MoodEntry] = []
    @Published var isSetupComplete: Bool = false

    private let dataService = DataService.shared
    private let notificationService = NotificationService.shared
    private var cancellables = Set<AnyCancellable>()

    init() {
        loadData()
    }

    func loadData() {
        sobrietyData = dataService.loadSobrietyData()
        settings = dataService.loadSettings()
        moodEntries = dataService.loadMoodEntries()
        isSetupComplete = sobrietyData != nil
    }

    func saveSobrietyData(_ data: SobrietyData) {
        self.sobrietyData = data
        dataService.saveSobrietyData(data)
        isSetupComplete = true

        // Schedule notifications
        if settings.notificationsEnabled {
            notificationService.scheduleNotifications(frequency: settings.notificationFrequency, sobrietyData: data)
        }
    }

    func updateSettings(_ newSettings: Settings) {
        self.settings = newSettings
        dataService.saveSettings(newSettings)

        // Update notifications
        if newSettings.notificationsEnabled, let data = sobrietyData {
            notificationService.scheduleNotifications(frequency: newSettings.notificationFrequency, sobrietyData: data)
        } else {
            notificationService.cancelAllNotifications()
        }
    }

    func addMoodEntry(_ entry: MoodEntry) {
        moodEntries.insert(entry, at: 0)
        dataService.saveMoodEntries(moodEntries)
    }

    func deleteMoodEntry(_ entry: MoodEntry) {
        moodEntries.removeAll { $0.id == entry.id }
        dataService.saveMoodEntries(moodEntries)
    }

    func getAchievedMilestones() -> [HealthMilestone] {
        guard let data = sobrietyData else { return [] }
        return HealthMilestone.milestones.filter { $0.isAchieved(daysSober: data.daysSober) }
    }

    func getNextMilestone() -> HealthMilestone? {
        guard let data = sobrietyData else { return nil }
        return HealthMilestone.milestones.first { !$0.isAchieved(daysSober: data.daysSober) }
    }

    func getUnlockedAchievements() -> [Achievement] {
        guard let data = sobrietyData else { return [] }
        return Achievement.achievements.filter { $0.isUnlocked(daysSober: data.daysSober) }
    }

    func getLockedAchievements() -> [Achievement] {
        guard let data = sobrietyData else { return Achievement.achievements }
        return Achievement.achievements.filter { !$0.isUnlocked(daysSober: data.daysSober) }
    }

    func resetAllData() {
        sobrietyData = nil
        moodEntries = []
        isSetupComplete = false
        dataService.clearAllData()
        notificationService.cancelAllNotifications()
    }
}
