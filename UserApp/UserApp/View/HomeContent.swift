import SwiftUI

struct HomeContent: View {
    @ObservedObject var homeViewModel: HomeViewModel

    var body: some View {
        VStack {
            Text("Welcome to Your Home Screen!")
                .font(.largeTitle)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity)
                .multilineTextAlignment(.center)
                .padding(.bottom, 40)

            Image(systemName: "person.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
                .foregroundColor(.black)
                .padding()
                .padding(.bottom, 40)

            Text("Tap on 'User' to view your profile details.")
                .font(.headline)
                .padding()
                .frame(maxWidth: .infinity)
                .multilineTextAlignment(.center)
                .padding(.bottom, 20)

            Button(action: {
                homeViewModel.navigateToProfile() 
            }) {
                Text("User")
                    .font(.title)
                    .padding()
                    .foregroundColor(.black)
                    .background(RoundedRectangle(cornerRadius: 8).fill(Color.gray.opacity(0.2)))
            }
            .padding(.bottom, 30)

            Spacer()
        }
        .padding(.top, 80)
    }
}

struct HomeContent_Previews: PreviewProvider {
    @State static var selectedTab = 0
    static var previews: some View {
        HomeContent(homeViewModel: HomeViewModel())
            .previewLayout(.sizeThatFits)
    }
}
