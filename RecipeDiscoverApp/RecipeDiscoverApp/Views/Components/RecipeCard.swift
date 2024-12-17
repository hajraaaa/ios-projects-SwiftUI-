import SwiftUI
import Kingfisher

struct RecipeCard: View {
    var recipe: Recipe

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            
// MARK: - Image Section
            ZStack(alignment: .bottomLeading) {
                KFImage(URL(string: recipe.image))
                    .resizable()
                    .scaledToFill()
                    .frame(height: 200)
                    .clipped()
//                    .cornerRadius(15, corners: [.topLeft, .topRight])
                
                Button(action: {
                    
                }) {
                    Text("Ratings: \(String(format: "%.1f", recipe.rating))")
                        .font(.satoshiBold(size: 13))
                        .foregroundColor(.black)
                        .padding(5)
                        .background(Color.white)
                        .cornerRadius(5)
                }
                .padding(15)

                HStack {
                    Spacer()
                    ZStack {
                        Circle()
                            .fill(Color.white)
                            .frame(width: 40, height: 40)
                            .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 4)

                        Image("Component 123 – 62")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 19, height: 17)
                    }
                    .padding(.trailing, 10)
                    .padding(.vertical, -20)
                }
            }

// MARK: - Title and Info Section
            VStack(alignment: .leading, spacing: 7) {
                Text(recipe.name)
                    .font(.satoshiMedium(size: 18))

                Text(recipe.mealType.joined(separator: ", "))
                    .font(.satoshiRegular(size: 14))
                    .foregroundColor(Color("itemText"))

                Text(recipe.difficulty.rawValue)
                    .font(.satoshiRegular(size: 14))
                    .foregroundColor(Color("navColor"))

                Text("Reviews: \(recipe.reviewCount)")
                    .font(.satoshiBold(size: 20))
                    .foregroundColor(Color("navColor"))
            }
            .padding(.horizontal, 13)

// MARK: - Time and Nutritional Info Section
            HStack(spacing: 10) {
                HStack(spacing: 5) {
                    Image("Parameter_icon")
                        .resizable()
                        .frame(width: 14, height: 14)
                    Text("\(recipe.prepTimeMinutes) mins prep")
                        .font(.satoshiMedium(size: 10))
                }

                HStack(spacing: 5){
                    Image("Group 90812")
                        .resizable()
                        .frame(width: 14, height: 14)
                    Text("\(recipe.cookTimeMinutes) mins cook")
                        .font(.satoshiMedium(size: 10))
                }
                
                HStack(spacing: 5) {
                    Image("Group 90810")
                        .resizable()
                        .frame(width: 14, height: 14)
                    Text("\(recipe.servings) servings")
                        .font(.satoshiMedium(size: 10))
                }

                HStack(spacing: 5) {
                    Image("Group 90813")
                        .resizable()
                        .frame(width: 14, height: 14)
                    Text("\(recipe.caloriesPerServing) calories")
                        .font(.satoshiMedium(size: 10))
                }

            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 10)
        }
        .padding(.bottom, 12)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.gray.opacity(0.3), radius: 12, x: 0, y: 0)
    }
}

// MARK: - Preview for RecipeCard Component
struct RecipeCard_Previews: PreviewProvider {
    static var previews: some View {
        let sampleRecipe = Recipe(
            id: 1,
            name: "Classic Margherita Pizza",
            ingredients: [
                "Pizza dough",
                "Tomato sauce",
                "Fresh mozzarella cheese",
                "Fresh basil leaves",
                "Olive oil",
                "Salt and pepper to taste"
            ],
            instructions: [
                "Preheat the oven to 475°F (245°C).",
                "Roll out the pizza dough and spread tomato sauce evenly.",
                "Top with slices of fresh mozzarella and fresh basil leaves.",
                "Drizzle with olive oil and season with salt and pepper.",
                "Bake in the preheated oven for 12-15 minutes or until the crust is golden brown.",
                "Slice and serve hot."
            ],
            prepTimeMinutes: 20,
            cookTimeMinutes: 15,
            servings: 4,
            difficulty: Difficulty(rawValue: "Easy") ?? .medium,
            cuisine: "Italian",
            caloriesPerServing: 300,
            tags: ["Pizza", "Italian"],
            userID: 166,
            image: "https://cdn.dummyjson.com/recipe-images/1.webp",
            rating: 4.6,
            reviewCount: 98,
            mealType: ["Dinner"]
        )

        RecipeCard(recipe: sampleRecipe)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
