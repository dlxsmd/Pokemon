import Foundation

// MARK: - PokemonApiModel

struct PokemonList: Codable {
    let results: [Result]
}

struct Result: Codable, Identifiable {
    var id: UUID {
        return UUID()
    }
    let name: String
    let url: String
    
    init(name: String, url: String) {
        self.name = name
        self.url = url
    }
}

// MARK: - PokemonApiModelTest
struct PokemonDetail: Codable,Identifiable {
    let height: Int
    let id: Int
    let sprites: Sprites
    let weight: Int
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case height
        case id
        case sprites
        case weight
        case name
    }
}




// MARK: - Sprites
class Sprites: Codable {
    let frontDefault: String?
    let frontShiny: String?

    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
        case frontShiny = "front_shiny"
    }
    
    init(frontDefault: String? = nil, frontShiny: String? = nil) {
        self.frontDefault = frontDefault
        self.frontShiny = frontShiny
    }
}

// MARK: - PokemonDetail2
struct PokemonDetail2: Codable, Identifiable {
    let color: Color?
    let flavorTextEntries: [FlavorTextEntry]
    let id: Int
    let name: String
    var jpname: String?
    let names: [Name]
    
    enum CodingKeys: String, CodingKey {
        case color
        case flavorTextEntries = "flavor_text_entries"
        case id
        case name
        case jpname
        case names
    }
}
// MARK: - Color
struct Color: Codable {
    let name: String
    let url: String
}


// MARK: - FlavorTextEntry
struct FlavorTextEntry: Codable {
    let flavorText: String
    let language: Color
    
    enum CodingKeys: String, CodingKey {
        case flavorText = "flavor_text"
        case language
    }

}

// MARK: - Name
struct Name: Codable {
    let language: Color
    let name: String
}


