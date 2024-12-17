import SwiftUI

struct HomeView: View {
    @StateObject private var homeViewModel = HomeViewModel()

    var body: some View {
        TabView(selection: $homeViewModel.selectedTab) {
            NavigationStack {
                HomeContent(homeViewModel: homeViewModel)
            }
            .tabItem {
                Image(systemName: "house.fill")
                Text("Home")
            }
            .tag(0)

            NavigationStack {
                ProfileView(homeViewModel: homeViewModel)
            }
            .tabItem {
                Image(systemName: "person.fill")
                Text("Profile")
            }
            .tag(1)

            NavigationStack {
                SettingsView(homeViewModel: homeViewModel)
            }
            .tabItem {
                Image(systemName: "gearshape.fill")
                Text("Settings")
            }
            .tag(2)
        }
        .tint(.black)
    }
}

#Preview {
    HomeView()
}
