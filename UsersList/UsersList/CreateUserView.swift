import SwiftUI
import SwiftData

struct CreateUserView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.presentationMode) var presentationMode
    @Query private var users: [User]
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var designation: String = ""
    @State private var email: String = ""
    @State private var showAlert: Bool = false
    @State private var alertTitle: String = ""
    @State private var alertMessage: String = ""

    var body: some View {
        Form {
            Section {
                TextField("First Name", text: $firstName)
                TextField("Last Name", text: $lastName)
                TextField("Designation", text: $designation)
                TextField("Email", text: $email)
                    .keyboardType(.emailAddress)
            }
            
            Button("Create") {
                createUser()
            }
        }
        .navigationTitle("Create User")
        .alert(isPresented: $showAlert) {
            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK"), action: {
                presentationMode.wrappedValue.dismiss()
            }))
        }
    }

    private func createUser() {
        if validateFields() {
            if users.contains(where: { $0.email.lowercased() == email.lowercased() }) {
                alertTitle = "Duplicate Error"
                alertMessage = "A user with this email already exists."
                showAlert = true
            } else {
                let newUser = User(firstName: firstName, lastName: lastName, designation: designation, email: email)
                modelContext.insert(newUser)

                alertTitle = "Success"
                alertMessage = "User created successfully."
                showAlert = true
            }
        } else {
            showAlert = true
        }
    }

    private func validateFields() -> Bool {
        if firstName.isEmpty || lastName.isEmpty || designation.isEmpty || email.isEmpty {
            alertTitle = "Validation Error"
            alertMessage = "All fields are required."
            return false
        }

        if !isAlphabetic(firstName) || !isAlphabetic(lastName) {
            alertTitle = "Validation Error"
            alertMessage = "Names can only contain alphabets."
            return false
        }

        if !isValidEmail(email) {
            alertTitle = "Validation Error"
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
}

#Preview {
    CreateUserView()
}
