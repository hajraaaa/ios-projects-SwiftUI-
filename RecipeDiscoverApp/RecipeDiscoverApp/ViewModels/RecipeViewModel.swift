import Foundation
import Combine
import SwiftData
import Network 

class RecipeViewModel: ObservableObject {
    @Published var recipes: [Recipe] = []
    @Published var uniqueTags: [String] = []
    @Published var filteredRecipes: [Recipe] = []
    @Published var loading: Bool = false
    @Published var selectedTag: String = "All" {
        didSet {
            filterRecipesByTag()
        }
    }

    private var cancellables = Set<AnyCancellable>()
    
    func fetchRecipes(context: ModelContext) {
        loading = true
        checkInternetConnection { isConnected in
            if isConnected {
                self.fetchRecipesFromAPI(context: context)
            } else {
                self.fetchRecipesFromDatabase(context: context)
            }
        }
    }

    private func fetchRecipesFromAPI(context: ModelContext) {
        NetworkManager.shared.get(endpoint: "/recipes") { (result: Result<RecipeResponse, Error>) in
            DispatchQueue.main.async {
                self.loading = false
                switch result {
                case .success(let recipeResponse):
                    self.recipes = recipeResponse.recipes
                    self.uniqueTags = ["All"] + Array(Set(self.recipes.flatMap { $0.tags }))
                    self.filterRecipesByTag()
                    self.saveRecipesToDatabase(context: context)
                case .failure(let error):
                    print("Error fetching recipes: \(error.localizedDescription)")
                }
            }
        }
    }

    private func fetchRecipesFromDatabase(context: ModelContext) {
        loading = true
        print("Current context: \(context)")
        do {
            let fetchedRecipes = try context.fetch(FetchDescriptor<Recipe>())
            DispatchQueue.main.async {
                self.recipes = fetchedRecipes
                print("Fetched recipes from the database: \(self.recipes.map { $0.name })")
                self.uniqueTags = ["All"] + Array(Set(self.recipes.flatMap { $0.tags }))
                self.filterRecipesByTag()
                self.loading = false
            }
        } catch {
            print("Error fetching recipes from the database: \(error.localizedDescription)")
            loading = false
        }
    }
        
    private func saveRecipesToDatabase(context: ModelContext) {
        print("Saving recipes to the database...")
        
        do {
            let existingRecipes = try context.fetch(FetchDescriptor<Recipe>())
            let existingIDs = Set(existingRecipes.map { $0.id })
            
            for recipe in self.recipes where !existingIDs.contains(recipe.id) {
                context.insert(recipe)
                print("Inserted recipe into DB: \(recipe.name)")
            }
            
            try context.save() 
            print("Successfully saved recipes to the database.")
        } catch {
            print("Error saving recipes to the database: \(error.localizedDescription)")
        }
    }
    
    private func checkInternetConnection(completion: @escaping (Bool) -> Void) {
        let monitor = NWPathMonitor()
        let queue = DispatchQueue.global(qos: .background)
        
        monitor.pathUpdateHandler = { path in
            let isConnected = (path.status == .satisfied)
            monitor.cancel() 
            DispatchQueue.main.async {
                completion(isConnected)
            }
        }
        monitor.start(queue: queue)
    }
    
    func fetchTags() {
        NetworkManager.shared.get(endpoint: "/recipes/tags") { (result: Result<[String], Error>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let tags):
                    self.uniqueTags = ["All"] + tags
                case .failure(let error):
                    print("Error fetching tags: \(error.localizedDescription)")
                }
            }
        }
    }

    private func filterRecipesByTag() {
        if selectedTag == "All" {
            filteredRecipes = recipes
        } else {
            filteredRecipes = recipes.filter { $0.tags.contains(selectedTag) }
        }
    }
}
