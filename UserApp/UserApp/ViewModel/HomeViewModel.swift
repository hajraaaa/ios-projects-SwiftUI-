import Foundation
import SwiftUI

class HomeViewModel: ObservableObject {
    
    @Published var selectedTab: Int = 0
    
    func navigateToProfile() {
        selectedTab = 1
    }

    func navigateToSettings() {
        selectedTab = 2
    }
}
