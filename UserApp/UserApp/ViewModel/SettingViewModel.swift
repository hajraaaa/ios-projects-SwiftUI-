import Foundation

class SettingViewModel: ObservableObject {
    @Published var settings: Settings

    init(settings: Settings) {
        self.settings = settings
    }

    func toggleNotifications() {
        settings.notificationsEnabled.toggle()
    }

    func toggleDarkMode() {
        settings.isDarkMode.toggle()
    }
}
