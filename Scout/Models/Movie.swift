import Foundation

struct Movie: Identifiable, Codable, Hashable {
    let id: String
    let title: String
    
    // Custom coding keys to match our JSON structure
    enum CodingKeys: String, CodingKey {
        case id = "movie_id"
        case title = "name"
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Movie, rhs: Movie) -> Bool {
        lhs.id == rhs.id
    }
}

struct MovieData: Codable {
    let popular: [Movie]
    let all: [Movie]
} 