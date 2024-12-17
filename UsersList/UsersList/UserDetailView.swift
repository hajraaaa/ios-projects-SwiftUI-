import SwiftUI
import SwiftData

struct UserDetailView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.presentationMode) var presentationMode
    @State var user: User
    @State private var firstName: String
    @State private var lastName: String
    @State private var designation: String
    @State private var email: String
    @State private var showAlert = false
    @State private var alertMessage = ""

    init(user: User) {
        _user = State(initialValue: user)
        _firstName = State(initialValue: user.firstName)
        _lastName = State(initialValue: user.lastName)
        _designation = State(initialValue: user.designation)
        _email = State(initialValue: user.email)
    }

    var body: some View {
        Form {
            Section {
                TextField("First Name", text: $firstName)
                TextField("Last Name", text: $lastName)
                TextField("Designation", text: $designation)
                TextField("Email", text: $email)
                    .keyboardType(.emailAddress)
            }
            Button("Update") {
                if validateFields() {
                    if fieldsHaveChanged() {
                        user.firstName = firstName
                        user.lastName = lastName
                        user.designation = designation
                        user.email = email

                        modelContext.insert(user)

                        alertMessage = "User Updated Successfully"
                    } else {
                        alertMessage = "No changes have been made."
                    }
                    showAlert = true
                } else {
                    showAlert = true
                }
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text(alertMessage), dismissButton: .default(Text("OK")) {
                    presentationMode.wrappedValue.dismiss()  
                })
            }
        }
        .navigationTitle("User Details")
    }

    private func validateFields() -> Bool {
        if firstName.isEmpty || lastName.isEmpty || designation.isEmpty || email.isEmpty {
            alertMessage = "All fields are required."
            return false
        }

        if !isAlphabetic(firstName) || !isAlphabetic(lastName) {
            alertMessage = "Names can only contain alphabets."
            return false
        }

        if !isValidEmail(email) {
            alertMessage = "Please enter a valid email address."
            return false
        }

        return true
    }

    private func isAlphabetic(_ value: String) -> Bool {
        let alphabeticRegex = "^[A-Za-z]+$"
        let alphabeticTest = NSPredicate(format: "SELF MATCHES %@", alphabeticRegex)
        return alphabeticTest.evaluate(with: value)
    }

    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}$"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: email)
    }

    private func fieldsHaveChanged() -> Bool {
        return firstName != user.firstName || lastName != user.lastName || designation != user.designation || email != user.email
    }
}

#Preview {
    UserDetailView(user: User(firstName: "John", lastName: "Doe", designation: "Developer", email: "john.doe@example.com"))
}
