import SwiftUI
import Combine

class PostViewModel: ObservableObject {
    @Published var posts: [Post] = []
    @Published var errorMessage: String = ""

    init() {
        fetchPosts()
    }

    func fetchPosts() {
        NetworkManager.shared.fetchPosts { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let posts):
                    self.posts = posts
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }

    func createPost(title: String, description: String) {
        let newPost = Post(id: Int.random(in: 1...1000), userId: 1, title: title, description: description)
        NetworkManager.shared.createPost(post: newPost) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let post):
                    self.posts.insert(post, at: 0)
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }

    func updatePost(post: Post) {
        NetworkManager.shared.updatePost(post: post) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let updatedPost):
                    if let index = self.posts.firstIndex(where: { $0.id == updatedPost.id }) {
                        self.posts[index] = updatedPost
                    }
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }

    func deletePost(id: Int) {
        NetworkManager.shared.deletePost(id: id) { result in
            DispatchQueue.main.async {
                switch result {
                case .success():
                    if let index = self.posts.firstIndex(where: { $0.id == id }) {
                        self.posts.remove(at: index)
                    }
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
