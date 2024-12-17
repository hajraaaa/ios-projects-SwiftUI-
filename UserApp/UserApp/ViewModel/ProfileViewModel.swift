import Foundation

class ProfileViewModel: ObservableObject {
    @Published var profile: Profile

//    init(profile: Profile) {
//        self.profile = profile
//    }
    
    init(profile: Profile = Profile(name: "Hajra Masood", email: "hajra@gmail.com", phone: "0900-78601")) {
            self.profile = profile
        }

    func updateProfile(name: String, email: String, phone: String) {
        profile.name = name
        profile.email = email
        profile.phone = phone
    }

    func navigateToSettings(homeViewModel: HomeViewModel) {
        homeViewModel.selectedTab = 2
    }
}


