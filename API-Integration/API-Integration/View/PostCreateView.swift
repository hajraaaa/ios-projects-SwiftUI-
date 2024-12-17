import SwiftUI

struct PostCreateView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: PostViewModel
    @Binding var isPresented: Bool
    @State private var title: String = ""
    @State private var description: String = ""
    @State private var isCreating: Bool = false

    var body: some View {
        Form {
            Section(header: Text("Title")) {
                TextField("Enter post title", text: $title)
            }

            Section(header: Text("Description")) {
                TextField("Enter post description", text: $description)
            }

            Button(action: createPost) {
                if isCreating {
                    ProgressView()
                } else {
                    Text("Create Post")
                }
            }
            .disabled(isCreating)
        }
        .navigationTitle("Create Post")
    }

    private func createPost() {
        isCreating = true
        viewModel.createPost(title: title, description: description)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { 
            isPresented = false
            presentationMode.wrappedValue.dismiss()
            isCreating = false 
        }
    }
}

#Preview {
    PostCreateView(viewModel: PostViewModel(), isPresented: .constant(false))
}
