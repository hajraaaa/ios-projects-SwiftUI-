import SwiftUI

struct ProfileView: View {
    @ObservedObject var homeViewModel: HomeViewModel
    
    @StateObject private var profileViewModel = ProfileViewModel()
    
    @State private var showDetails = false

    var body: some View {
        VStack {
            Text("Welcome to Your Profile!")
                .font(.title)
                .fontWeight(.bold)
                .padding()

            Text("This is where you can view and edit your personal information.")
                .font(.headline)
                .padding()

            VStack(alignment: .leading, spacing: 20) {
                Text("Name: \(profileViewModel.profile.name)")
                    .font(.title2)

                Text("Email: \(profileViewModel.profile.email)")
                    .font(.title2)
                    .foregroundColor(.black)

                Text("Phone: \(profileViewModel.profile.phone)")
                    .font(.title2)
            }
            .padding()

            Button(action: {
                showDetails = true
            }) {
                Text("View Details")
                    .font(.title)
                    .foregroundColor(.black)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 8).fill(Color.gray.opacity(0.2)))
            }
            .padding(.top, 20)

            Spacer()
        }
        .padding()
        .fullScreenCover(isPresented: $showDetails) {
            DetailsView(selectedTab: $homeViewModel.selectedTab)
        }
    }
}

#Preview {
    ProfileView(homeViewModel: HomeViewModel())
}
