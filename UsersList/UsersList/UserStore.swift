import Foundation
import Combine

class UserStore: ObservableObject {
    @Published var users: [User] = []
    
    func addUser(_ user: User) {
        users.append(user)
    }

    func updateUser(id: UUID, newUser: User) {
        if let index = users.firstIndex(where: { $0.id == id }) {
            users[index] = newUser
        }
    }
    
    func deleteUser(id: UUID) {
        users.removeAll { $0.id == id }
    }
}
