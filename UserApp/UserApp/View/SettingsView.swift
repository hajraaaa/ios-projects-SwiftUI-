import SwiftUI

struct SettingsView: View {
    @ObservedObject var homeViewModel: HomeViewModel
    @StateObject private var settingViewModel = SettingViewModel(settings: Settings(notificationsEnabled: true, sharingEnabled: false, isDarkMode: false))

    var body: some View {
        VStack {
            Text("Settings")
                .font(.largeTitle)
                .padding()

            Toggle("Enable Notifications", isOn: $settingViewModel.settings.notificationsEnabled)
            Toggle("Share Data with Third Parties", isOn: $settingViewModel.settings.sharingEnabled)
            Toggle("Dark Mode", isOn: $settingViewModel.settings.isDarkMode)

            Spacer()
        }
        .padding()
        .onAppear {
            homeViewModel.selectedTab = 2
        }
    }
}

#Preview {
    SettingsView(homeViewModel: HomeViewModel())
}
