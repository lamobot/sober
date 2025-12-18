import SwiftUI

@main
struct SoberApp: App {
    @StateObject private var viewModel = SobrietyViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
                .onAppear {
                    NotificationService.shared.requestAuthorization { granted in
                        print("Notification permission: \(granted)")
                    }
                }
        }
    }
}
