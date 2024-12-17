import SwiftUI

struct PostListView: View {
    @ObservedObject var viewModel: PostViewModel
    @State private var showingCreatePostView = false
    @State private var showingEditPostView = false
    @State private var selectedPost: Post?

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                HStack {
                    Text("Posts")
                        .font(.largeTitle)
                        .fontWeight(.bold)

                    Spacer()

                    Button(action: {
                        showingCreatePostView = true
                    }) {
                        HStack {
                            Text("Add Post")
                            Image(systemName: "plus")
                        }
                        .padding(10)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                    }
                }
                .padding()

                List {
                    ForEach(viewModel.posts) { post in
                        VStack(alignment: .leading) {
                            Text(post.title)
                                .font(.headline)
                            Text(post.description)
                                .font(.subheadline)
                        }
                        .onTapGesture {
                            selectedPost = post
                            showingEditPostView = true
                            print("Selected post: \(post.title)") 
                        }
                    }
                    .onDelete { indexSet in
                        if let index = indexSet.first {
                            let post = viewModel.posts[index]
                            viewModel.deletePost(id: post.id)
                        }
                    }
                }
            }
            .navigationBarHidden(true)
            .sheet(isPresented: $showingCreatePostView) {
                PostCreateView(viewModel: viewModel, isPresented: $showingCreatePostView)
            }
            .sheet(isPresented: $showingEditPostView) {
                if let selectedPost = selectedPost {
                    PostEditView(viewModel: viewModel, isPresented: $showingEditPostView, post: selectedPost)
                }
            }
        }
    }
}
#Preview {
    PostListView(viewModel: PostViewModel())
}
