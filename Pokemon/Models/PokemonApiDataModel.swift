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
    let abilities: [Ability]
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

// MARK: - PokemonApiModelTest2

struct PokemonDetail2: Codable {
    let color: Color
    let evolutionChain: EvolutionChain
    let flavorTextEntries: [FlavorTextEntry]
    let formDescriptions: [String?]
    let name: String
    let names: [Name]
    let shape: Color
}

// MARK: - Color
struct Color: Codable {
    let name: String
    let url: String
}

// MARK: - EvolutionChain
struct EvolutionChain: Codable {
    let url: String
}

// MARK: - FlavorTextEntry
struct FlavorTextEntry: Codable {
    let flavorText: String
    let language, version: Color
}



// MARK: - Name
struct Name: Codable {
    let language: Color
    let name: String
}

