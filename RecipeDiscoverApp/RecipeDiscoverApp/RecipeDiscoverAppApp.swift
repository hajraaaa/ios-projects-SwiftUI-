import SwiftUI

@main
struct RecipeDiscoverAppApp: App {
    @State private var isLaunchScreenActive = true
    var body: some Scene {
        WindowGroup {
            if isLaunchScreenActive {
                LaunchScreenView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            isLaunchScreenActive = false
                        }
                    }
            } else {
                ContentView()
                    .modelContainer(for: [Recipe.self])
            }
        }
    }
}
