import SwiftUI

struct CategoryItem: View {
    var tags: [String]
    
    @Binding var selectedTag: String
    
    var allTags: [String] {
        var combinedTags = tags
        if !combinedTags.contains("All") {
            combinedTags.insert("All", at: 0)
        }
        return combinedTags
    }
    
    var body: some View {
        HStack (spacing: 10){
            ForEach(allTags, id: \.self) { tag in
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(selectedTag == tag ? Color("navColor").opacity(0.1) : Color("itemText").opacity(0.1))
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(selectedTag == tag ? Color("navColor") :Color("itemBorder"), lineWidth: 1)
                        )
                    Text(tag)
                        .font(.satoshiMedium(size: 14))
                        .foregroundStyle(selectedTag == tag ? Color("navColor") : Color("itemText"))
                        .padding(.vertical, 2)
                        .padding(.horizontal, 20)
                        .cornerRadius(20)
                                           
                }
                .frame(height: 36)
                .onTapGesture {
                    selectedTag = tag
                }
            }
        }
        .frame(height: 40)
    }
}

// MARK: - Preview for CategoryItem Component
struct CategoryItem_Previews: PreviewProvider {
    static var previews: some View {
        let sampleTags = ["Italian", "Pizza", "Dinner"]
        
        @State var selectedTag = "All"
        
        return CategoryItem(tags: sampleTags, selectedTag: $selectedTag)
            .previewLayout(.sizeThatFits)
            .padding()
            .background(Color(.systemBackground))
    }
}
