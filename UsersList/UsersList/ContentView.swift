import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var users: [User]

    var body: some View {
        NavigationSplitView {
            List {
                ForEach(users) { user in
                    NavigationLink {
                        UserDetailView(user: user)
                            .environment(\.modelContext, modelContext)
                    } label: {
                        Text("\(user.firstName) \(user.lastName)")
                    }
                }
                
                .onDelete(perform: deleteUsers)
            }
            .navigationTitle("List of Users")
            .toolbar {
             ToolbarItem(placement: .navigationBarTrailing) {
             NavigationLink(destination: CreateUserView()) {
             Label("", systemImage: "plus")
                                }
                            }
                        }
        } detail: {
            Text("Select a user")
        }
    }

    private func deleteUsers(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(users[index])
            }
        }
    }
}

#Preview {
    ContentView()
}
