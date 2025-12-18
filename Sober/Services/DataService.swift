import Foundation

class DataService {
    static let shared = DataService()

    private let sobrietyDataKey = "sobrietyData"
    private let settingsKey = "settings"
    private let moodEntriesKey = "moodEntries"

    private let userDefaults = UserDefaults.standard
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()

    private init() {}

    // MARK: - Sobriety Data

    func saveSobrietyData(_ data: SobrietyData) {
        if let encoded = try? encoder.encode(data) {
            userDefaults.set(encoded, forKey: sobrietyDataKey)
        }
    }

    func loadSobrietyData() -> SobrietyData? {
        guard let data = userDefaults.data(forKey: sobrietyDataKey),
              let decoded = try? decoder.decode(SobrietyData.self, from: data) else {
            return nil
        }
        return decoded
    }

    // MARK: - Settings

    func saveSettings(_ settings: Settings) {
        if let encoded = try? encoder.encode(settings) {
            userDefaults.set(encoded, forKey: settingsKey)
        }
    }

    func loadSettings() -> Settings {
        guard let data = userDefaults.data(forKey: settingsKey),
              let decoded = try? decoder.decode(Settings.self, from: data) else {
            return Settings()
        }
        return decoded
    }

    // MARK: - Mood Entries

    func saveMoodEntries(_ entries: [MoodEntry]) {
        if let encoded = try? encoder.encode(entries) {
            userDefaults.set(encoded, forKey: moodEntriesKey)
        }
    }

    func loadMoodEntries() -> [MoodEntry] {
        guard let data = userDefaults.data(forKey: moodEntriesKey),
              let decoded = try? decoder.decode([MoodEntry].self, from: data) else {
            return []
        }
        return decoded
    }

    // MARK: - Clear Data

    func clearAllData() {
        userDefaults.removeObject(forKey: sobrietyDataKey)
        userDefaults.removeObject(forKey: moodEntriesKey)
        // Keep settings
    }
}
