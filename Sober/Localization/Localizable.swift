import Foundation

// Centralized localization keys
enum L10n {
    // MARK: - Common
    static let appName = "Sober"
    static let ok = NSLocalizedString("ok", comment: "OK button")
    static let cancel = NSLocalizedString("cancel", comment: "Cancel button")
    static let save = NSLocalizedString("save", comment: "Save button")
    static let edit = NSLocalizedString("edit", comment: "Edit button")
    static let delete = NSLocalizedString("delete", comment: "Delete button")
    static let done = NSLocalizedString("done", comment: "Done button")

    // MARK: - Tabs
    static let tabMain = NSLocalizedString("tab.main", comment: "Main tab")
    static let tabHealth = NSLocalizedString("tab.health", comment: "Health tab")
    static let tabMood = NSLocalizedString("tab.mood", comment: "Mood tab")
    static let tabAchievements = NSLocalizedString("tab.achievements", comment: "Achievements tab")
    static let tabSettings = NSLocalizedString("tab.settings", comment: "Settings tab")

    // MARK: - Onboarding
    static let onboardingTitle = NSLocalizedString("onboarding.title", comment: "Onboarding title")
    static let onboardingSubtitle = NSLocalizedString("onboarding.subtitle", comment: "Onboarding subtitle")
    static let onboardingStartDate = NSLocalizedString("onboarding.start_date", comment: "Start date label")
    static let onboardingFinancialParams = NSLocalizedString("onboarding.financial_params", comment: "Financial parameters")
    static let onboardingAlcoholCost = NSLocalizedString("onboarding.alcohol_cost", comment: "Alcohol cost placeholder")
    static let onboardingRelatedCost = NSLocalizedString("onboarding.related_cost", comment: "Related costs placeholder")
    static let onboardingRelatedHint = NSLocalizedString("onboarding.related_hint", comment: "Related costs hint")
    static let onboardingTimeLost = NSLocalizedString("onboarding.time_lost", comment: "Time lost section")
    static let onboardingTimeLostPlaceholder = NSLocalizedString("onboarding.time_lost_placeholder", comment: "Days per month")
    static let onboardingTimeLostHint = NSLocalizedString("onboarding.time_lost_hint", comment: "Hangover recovery hint")
    static let onboardingStart = NSLocalizedString("onboarding.start", comment: "Start button")
    static let onboardingError = NSLocalizedString("onboarding.error", comment: "Error title")
    static let onboardingErrorMessage = NSLocalizedString("onboarding.error_message", comment: "Error message")

    // MARK: - Main Screen
    static let mainSoberSince = NSLocalizedString("main.sober_since", comment: "Sober since text")
    static let mainMoneySaved = NSLocalizedString("main.money_saved", comment: "Money saved")
    static let mainTimeSaved = NSLocalizedString("main.time_saved", comment: "Time saved")
    static let mainDaysStreak = NSLocalizedString("main.days_streak", comment: "Days streak")
    static let mainProjections = NSLocalizedString("main.projections", comment: "Projections title")
    static let mainProjection6Months = NSLocalizedString("main.projection_6months", comment: "In 6 months")
    static let mainProjection12Months = NSLocalizedString("main.projection_12months", comment: "In 12 months")
    static let mainNextMilestone = NSLocalizedString("main.next_milestone", comment: "Next milestone")
    static let mainDaysRemaining = NSLocalizedString("main.days_remaining", comment: "Days remaining")

    // MARK: - Time Units
    static let timeDay = NSLocalizedString("time.day", comment: "day")
    static let timeDays = NSLocalizedString("time.days", comment: "days")
    static let timeWeek = NSLocalizedString("time.week", comment: "week")
    static let timeWeeks = NSLocalizedString("time.weeks", comment: "weeks")
    static let timeMonth = NSLocalizedString("time.month", comment: "month")
    static let timeMonths = NSLocalizedString("time.months", comment: "months")
    static let timeYear = NSLocalizedString("time.year", comment: "year")
    static let timeYears = NSLocalizedString("time.years", comment: "years")

    // MARK: - Settings
    static let settingsTitle = NSLocalizedString("settings.title", comment: "Settings")
    static let settingsInfo = NSLocalizedString("settings.info", comment: "Information section")
    static let settingsStartDate = NSLocalizedString("settings.start_date", comment: "Start date")
    static let settingsAlcoholCost = NSLocalizedString("settings.alcohol_cost", comment: "Alcohol expenses")
    static let settingsRelatedCost = NSLocalizedString("settings.related_cost", comment: "Related expenses")
    static let settingsTimeLost = NSLocalizedString("settings.time_lost", comment: "Lost time")
    static let settingsNotifications = NSLocalizedString("settings.notifications", comment: "Notifications section")
    static let settingsNotificationsEnable = NSLocalizedString("settings.notifications_enable", comment: "Enable notifications")
    static let settingsNotificationsFrequency = NSLocalizedString("settings.notifications_frequency", comment: "Frequency")
    static let settingsLanguage = NSLocalizedString("settings.language", comment: "Language")
    static let settingsData = NSLocalizedString("settings.data", comment: "Data section")
    static let settingsResetData = NSLocalizedString("settings.reset_data", comment: "Reset all data")
    static let settingsAbout = NSLocalizedString("settings.about", comment: "About section")
    static let settingsVersion = NSLocalizedString("settings.version", comment: "Version")
    static let settingsSupport = NSLocalizedString("settings.support", comment: "Support")
    static let settingsResetAlert = NSLocalizedString("settings.reset_alert", comment: "Reset data alert title")
    static let settingsResetMessage = NSLocalizedString("settings.reset_message", comment: "Reset confirmation message")

    // MARK: - Health
    static let healthTitle = NSLocalizedString("health.title", comment: "Health title")
    static let healthProgress = NSLocalizedString("health.progress", comment: "Your progress")
    static let healthMilestonesAchieved = NSLocalizedString("health.milestones_achieved", comment: "Milestones achieved")
    static let healthCompleted = NSLocalizedString("health.completed", comment: "Completed stages")
    static let healthNext = NSLocalizedString("health.next", comment: "Next stage")
    static let healthUpcoming = NSLocalizedString("health.upcoming", comment: "Upcoming stages")

    // MARK: - Mood
    static let moodTitle = NSLocalizedString("mood.title", comment: "Mood title")
    static let moodTrackTitle = NSLocalizedString("mood.track_title", comment: "Track your mood")
    static let moodTrackSubtitle = NSLocalizedString("mood.track_subtitle", comment: "Start tracking subtitle")
    static let moodAddEntry = NSLocalizedString("mood.add_entry", comment: "Add entry")
    static let moodRecentEntries = NSLocalizedString("mood.recent_entries", comment: "Recent entries")
    static let moodStatistics = NSLocalizedString("mood.statistics", comment: "Statistics")
    static let moodAverage = NSLocalizedString("mood.average", comment: "Average mood")
    static let moodTotalEntries = NSLocalizedString("mood.total_entries", comment: "Total entries")
    static let moodMostCommon = NSLocalizedString("mood.most_common", comment: "Most common mood")
    static let moodAddTitle = NSLocalizedString("mood.add_title", comment: "Add mood entry")
    static let moodHowFeeling = NSLocalizedString("mood.how_feeling", comment: "How are you feeling?")
    static let moodNotes = NSLocalizedString("mood.notes", comment: "Notes (optional)")

    // MARK: - Achievements
    static let achievementsTitle = NSLocalizedString("achievements.title", comment: "Achievements")
    static let achievementsUnlocked = NSLocalizedString("achievements.unlocked", comment: "Unlocked")
    static let achievementsUnlockedSection = NSLocalizedString("achievements.unlocked_section", comment: "Unlocked achievements")
    static let achievementsLockedSection = NSLocalizedString("achievements.locked_section", comment: "Locked achievements")
    static let achievementsDaysRemaining = NSLocalizedString("achievements.days_remaining", comment: "In N days")
}
