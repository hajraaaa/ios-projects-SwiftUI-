import Foundation

class CategoryViewModel: ObservableObject {
    @Published var categories: [String] = []

    func fetchCategories(using tags: [String]) {
        categories = Array(Set(tags))
    }
}
