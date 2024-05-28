//
//  PokemonDetailView.swift
//  Pokemon
//
//  Created by yuki on 2024/05/28.
//

import SwiftUI

struct PokemonDetailView: View {
    let pokemon: Result
    var body: some View {
        VStack{
            Text(pokemon.name)
            Text(pokemon.url)
        }
    }
}

#Preview {
    PokemonDetailView(pokemon: Result(name: "Pikachu", url: "https://pokeapi.co/api/v2/pokemon/25/"))
}
