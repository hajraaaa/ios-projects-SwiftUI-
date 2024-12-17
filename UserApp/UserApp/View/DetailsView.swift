import SwiftUI

struct DetailsView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Binding var selectedTab: Int

    var body: some View {
        VStack {
            Text("Profile Information")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()

            Text("Detailed information about the user.")
                .font(.headline)
                .padding(.bottom, 20)

            VStack(alignment: .leading, spacing: 10) {
                Text("Name: Hajra Masood")
                    .font(.title2)
                Text("Email: hajra@gmail.com")
                    .font(.title2)
                Text("Phone: 0900-78601")
                    .font(.title2)
            }
            .padding()

            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Text("Back to Profile")
                    .font(.title)
                    .foregroundColor(.black)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 8).fill(Color.gray.opacity(0.2)))
            }
            .padding(.top, 20)

            Spacer()
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                    selectedTab = 2
                }) {
                    Image(systemName: "gearshape.fill")
                        .foregroundColor(.black)
                }
            }
        }
        .padding()
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    DetailsView(selectedTab: .constant(1))
}
