import SwiftUI
import SwiftData

struct ContentView: View {
    @StateObject private var recipeViewModel = RecipeViewModel()
    @Environment(\.modelContext) private var context

    var body: some View {
        ZStack {
            VStack {
// MARK: - Custom Navigation Bar
                CustomNavBar()
                
// MARK: - Scrollable Category Section
                ScrollView(.horizontal, showsIndicators: false) {
                    CategoryItem(tags: recipeViewModel.uniqueTags, selectedTag: $recipeViewModel.selectedTag)
                }
                .padding(EdgeInsets(top: 14, leading: 25, bottom: 0, trailing: 0))
                
// MARK: - Scrollable Recipe Cards Section
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        ForEach(recipeViewModel.filteredRecipes, id: \.id) { recipe in
                         RecipeCard(recipe: recipe)
                                .padding(.bottom, 10)
                        }
                    }
                    .padding(.horizontal, 25)
                    .padding(.vertical, 10)
                }
            }
            .onAppear {
                recipeViewModel.fetchRecipes(context: context)
                print("Fetching recipes...")
            }
            .onChange(of: recipeViewModel.filteredRecipes) { newRecipes in
                print("Updated filtered recipes: \(newRecipes)")
                        }
            .edgesIgnoringSafeArea(.top)
            
                if recipeViewModel.loading {
                    Color.white
                    .edgesIgnoringSafeArea(.all)
                    
                    VStack {
                        ProgressView("Loading...")
                            .progressViewStyle(CircularProgressViewStyle())
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                    }
                }
            }

        }
    }


// MARK: - Preview for ContentView
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .modelContainer(for: [Recipe.self])
    }
}
