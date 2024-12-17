import SwiftUI

@main
struct API_IntegrationApp: App {
    
    @StateObject private var viewModel = PostViewModel()

    var body: some Scene {
        WindowGroup {
            PostListView(viewModel: viewModel)
        }
    }
}
