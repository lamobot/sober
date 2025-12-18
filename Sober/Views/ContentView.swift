import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: SobrietyViewModel

    var body: some View {
        if viewModel.isSetupComplete {
            TabView {
                MainView()
                    .tabItem {
                        Label(NSLocalizedString("tab.main", comment: ""), systemImage: "house.fill")
                    }

                HealthView()
                    .tabItem {
                        Label(NSLocalizedString("tab.health", comment: ""), systemImage: "heart.fill")
                    }

                MoodView()
                    .tabItem {
                        Label(NSLocalizedString("tab.mood", comment: ""), systemImage: "face.smiling")
                    }

                AchievementsView()
                    .tabItem {
                        Label(NSLocalizedString("tab.achievements", comment: ""), systemImage: "trophy.fill")
                    }

                SettingsView()
                    .tabItem {
                        Label(NSLocalizedString("tab.settings", comment: ""), systemImage: "gearshape.fill")
                    }
            }
        } else {
            OnboardingView()
        }
    }
}
