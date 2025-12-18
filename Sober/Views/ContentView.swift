import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: SobrietyViewModel

    var body: some View {
        if viewModel.isSetupComplete {
            TabView {
                MainView()
                    .tabItem {
                        Label("Главная", systemImage: "house.fill")
                    }

                HealthView()
                    .tabItem {
                        Label("Здоровье", systemImage: "heart.fill")
                    }

                MoodView()
                    .tabItem {
                        Label("Настроение", systemImage: "face.smiling")
                    }

                AchievementsView()
                    .tabItem {
                        Label("Достижения", systemImage: "trophy.fill")
                    }

                SettingsView()
                    .tabItem {
                        Label("Настройки", systemImage: "gearshape.fill")
                    }
            }
        } else {
            OnboardingView()
        }
    }
}
