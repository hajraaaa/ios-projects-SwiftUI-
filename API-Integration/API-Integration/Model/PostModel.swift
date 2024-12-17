import Foundation

struct Post: Identifiable, Codable {
    let id: Int
    let userId: Int
    var title: String
    var description: String
    
    enum CodingKeys: String, CodingKey {
        case id, userId, title
        case description = "body"
    }
}
