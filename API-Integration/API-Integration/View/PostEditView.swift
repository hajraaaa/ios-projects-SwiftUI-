import SwiftUI

struct PostEditView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: PostViewModel
    @Binding var isPresented: Bool
    @State var post: Post

    var body: some View {
        VStack {
            Form {
                Section(header: Text("Title")) {
                    TextField("Enter post title", text: $post.title)
                }

                Section(header: Text("Description")) {
                    TextField("Enter post description", text: $post.description)
                }
                Button("Update Post") {
                viewModel.updatePost(post: post)
                isPresented = false
                presentationMode.wrappedValue.dismiss()
                }
            }
            .navigationTitle("Edit Post")
                
        }
    }
}
struct PostEditView_Previews: PreviewProvider {
    static var samplePost = Post(id: 1, userId: 1, title: "Sample Title", description: "Sample Description")

    @State static var isPresented: Bool = true

    static var previews: some View {
        PostEditView(viewModel: PostViewModel(), isPresented: $isPresented, post: samplePost)
    }
}
