import SwiftUI

@main
struct SoberApp: App {
    @StateObject private var viewModel = SobrietyViewModel()
    @StateObject private var localizationService = LocalizationService.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
                .environmentObject(localizationService)
                .environment(\.locale, localizationService.currentLanguage.locale)
                .id(localizationService.currentLanguage)
                .onAppear {
                    NotificationService.shared.requestAuthorization { granted in
                        print("Notification permission: \(granted)")
                    }
                }
        }
    }
}
