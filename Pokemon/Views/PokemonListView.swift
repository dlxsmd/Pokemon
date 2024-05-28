//
//  PokemonListView.swift
//  Pokemon
//
//  Created by yuki on 2024/05/27.
//

import SwiftUI

struct PokemonListView: View {
    @ObservedObject var model = PokemonApiModelTest.shared
    var body: some View {
        NavigationStack{
            List(self.model.pokemonDetail){ pokemon in
                NavigationLink(destination:PokemonDetailView(pokemon: pokemon)){
                    PokemonRowView(pokemonDetail: pokemon)
                }
            }
            .onAppear{
                model.setPokemon(params: PokemonParametersModel(limit: 10000, offset: 0))
            }
        }
    }
}

#Preview {
    PokemonListView()
}