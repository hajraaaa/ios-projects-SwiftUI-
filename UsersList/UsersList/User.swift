import Foundation
import SwiftData

@Model
class User: Identifiable {
    var id: UUID
    var firstName: String
    var lastName: String
    var designation: String
    var email: String

    init(id: UUID = UUID(), firstName: String, lastName: String, designation: String, email: String) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.designation = designation
        self.email = email
    }
}

