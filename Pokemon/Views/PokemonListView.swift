//
//  PokemonListView.swift
//  Pokemon
//
//  Created by yuki on 2024/05/27.
//

import SwiftUI
import SwiftData

struct PokemonListView: View {
    @ObservedObject var model = PokemonApiModelTest.shared
    @State var searchtext = ""
    var body: some View {
        
        NavigationStack {
            List(filterdpokemon) { result in
                NavigationLink(destination: PokemonDetailView(pokemonDetail: result)) {
                    PokemonRowView(pokemonDetail: result)
                }
            }
            .onAppear {
                model.setPokemon(params: PokemonParametersModel(limit: 10000, offset: 0))
            }
        }.searchable(text: $searchtext,placement: .navigationBarDrawer(displayMode: .always))

    }
    
    var filterdpokemon: [PokemonDetail] {
        if searchtext.isEmpty {
            return model.pokemonDetails
        } else {
            return model.pokemonDetails.filter { $0.name.contains(searchtext) }
        }
    }
}


#Preview {
    PokemonListView()
}
