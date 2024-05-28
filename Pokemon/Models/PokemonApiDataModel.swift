//
//  PokemonApiDataModel.swift
//  Pokemon
//
//  Created by yuki on 2024/05/27.
//

import Foundation

struct PokemonList: Codable{
    let results: [Result]
}

struct Result:Codable,Identifiable{
    var id:UUID{
        return UUID()
    }
    let name: String
    let url: String
    
    init(name:String,url:String){
        self.name = name
        self.url = url
    }
}

struct PokemonDetail: Codable{
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
}

// MARK: - Ability
struct Ability: Codable {
    let ability: Species
    let isHidden: Bool
    let slot: Int
}

// MARK: - Species
struct Species: Codable {
    let name: String
    let url: String
}

class Sprites: Codable {
    let backDefault: String

    let backShiny: String

    let frontDefault: String

    let frontShiny: String

    let animated: Sprites?

    init(backDefault: String, backShiny: String, frontDefault: String, frontShiny: String,animated: Sprites?) {
        self.backDefault = backDefault
        self.backShiny = backShiny
        self.frontDefault = frontDefault
        self.frontShiny = frontShiny
        self.animated = animated
    }
}
