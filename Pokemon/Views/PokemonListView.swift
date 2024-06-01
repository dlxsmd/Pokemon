//
//  PokemonListView.swift
//  Pokemon
//
//  Created by yuki on 2024/05/27.
//

import SwiftUI
import SwiftData

struct PokemonListView: View {
    @ObservedObject var model = PokemonApiModelTest2.shared
    
    @State var searchtext = ""
    var body: some View {
        
        NavigationStack {
            List(filterdpokemon.sorted(by: { $0.id < $1.id })) { result in
                if let pokemonDetail2 = model.pokemonDetails2.first(where: { $0.id == result.id }){
                    NavigationLink(destination: PokemonDetailView(pokemonDetail: result,pokemonDetail2:pokemonDetail2)) {
                        PokemonRowView(pokemonDetail: result,pokemonDetail2:pokemonDetail2)
                    }
                }
            }
            .onAppear {
                model.setPokemon(params: PokemonParametersModel(limit: 1025, offset: 0))
            }
            .animation(.easeInOut(duration: 0.5),value: filterdpokemon.count)
        }.searchable(text: $searchtext,placement: .navigationBarDrawer(displayMode: .always))

    }
    
    var filterdpokemon: [PokemonDetail] {
        if searchtext.isEmpty {
            return model.pokemonDetails
        } else {
            return model.pokemonDetails.filter {
                $0.name.contains(searchtext) }
        }
    }
}


#Preview {
    PokemonListView()
}
