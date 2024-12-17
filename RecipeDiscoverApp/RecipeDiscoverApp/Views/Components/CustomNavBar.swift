import SwiftUI

struct CustomNavBar: View {
    @State private var searchText = ""

    var body: some View {
        ZStack {
            Color("navColor")
                .cornerRadius(35, corners: [.bottomLeft, .bottomRight])
                .ignoresSafeArea(edges: .top)

            VStack(spacing: 15) {
                HStack {
                    Text("Discover New Recipe!")
                        .font(.satoshiMedium(size: 22))
                        .foregroundColor(.white)
                    Spacer()

                    Image("Group 15934")
                    .resizable()
                    .frame(width: 24, height: 24)
                }
            
                HStack {
                    Image("Search_icon")
                        .resizable()
                        .frame(width: 20, height: 20)
                    TextField("Search here ...", text: $searchText)
                        .font(.satoshiMedium(size: 18))
                        .foregroundColor(Color("searchBar"))
                }
                .padding()
                .background(Color(.white))
                .cornerRadius(28)
                .padding(.top, 5)
                

                HStack(spacing: 0) {
                    Image("Current_location_icon")
                        .resizable()
                        .frame(width: 20, height: 20)
                    Spacer()
                        .frame(width: 10)
                    Text("Current Receipe Name")
                        .foregroundColor(.white)
                        .font(.satoshiMedium(size: 14))
                    Image(systemName: "chevron.right")
                        .foregroundColor(.white)
                        .frame(width: 7, height: 12)
                    Spacer()
                }
                .padding(.horizontal,11)
            }
            .padding(EdgeInsets(top: 50, leading: 25, bottom: 16, trailing: 25))
        }
        .frame(height: 206)
    }
}

// MARK: Extension for Custom Corner Radius
struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct CustomNavBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavBar()
    }
}

