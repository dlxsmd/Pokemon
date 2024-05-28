import Foundation

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

struct PokemonDetail: Codable,Identifiable {
    let abilities: [Ability]
    let baseExperience: Int
    let forms: [Species]
    let height: Int
    let id: Int
    let name: String
    let order: Int
    let species: Species
    let sprites: Sprites
    let weight: Int
    
    enum CodingKeys: String, CodingKey {
        case abilities
        case baseExperience = "base_experience"
        case forms
        case height
        case id
        case name
        case order
        case species
        case sprites
        case weight
    }
}

// MARK: - Ability
struct Ability: Codable {
    let ability: Species
    let isHidden: Bool
    let slot: Int
    
    enum CodingKeys: String, CodingKey {
        case ability
        case isHidden = "is_hidden"
        case slot
    }
}

// MARK: - Species
struct Species: Codable {
    let name: String
    let url: String
}

// MARK: - Sprites
class Sprites: Codable {
    let backDefault: String
    let backShiny: String
    let frontDefault: String
    let frontShiny: String
    let animated: Sprites?
    
    enum CodingKeys: String, CodingKey {
        case backDefault = "back_default"
        case backShiny = "back_shiny"
        case frontDefault = "front_default"
        case frontShiny = "front_shiny"
        case animated
    }
    
    init(backDefault: String, backShiny: String, frontDefault: String, frontShiny: String, animated: Sprites?) {
        self.backDefault = backDefault
        self.backShiny = backShiny
        self.frontDefault = frontDefault
        self.frontShiny = frontShiny
        self.animated = animated
    }
}
