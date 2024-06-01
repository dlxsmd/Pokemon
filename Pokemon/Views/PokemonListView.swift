//
//  PokemonListView.swift
//  Pokemon
//
//  Created by yuki on 2024/05/27.
//

import SwiftUI
import SwiftData

struct PokemonListView: View {
    @ObservedObject var model = PokemonApiModel.shared
    
    @State var searchtext = ""
    @State var isReverse = false
    var body: some View {
        
        NavigationStack {
            List(filterdpokemon.sorted(by: isReverse ?  { $0.id > $1.id } : { $0.id < $1.id })) { result in
                if let pokemonDetail = model.pokemonDetails.first(where: { $0.id == result.id }){
                    NavigationLink(destination: PokemonDetailView(pokemonDetail: pokemonDetail,pokemonDetail2:result)) {
                        PokemonRowView(pokemonDetail: pokemonDetail,pokemonDetail2:result)
                    }
                }
            }
            .animation(.easeInOut(duration: 0.5),value: filterdpokemon.count)
            .navigationTitle("ポケモン図鑑")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isReverse.toggle()
                    }) {
                        Image(systemName: isReverse ? "arrow.up.circle" : "arrow.down.circle")
                            .font(.title2)
                    }
                }
            }
        }
        .searchable(text: $searchtext,placement:
                .navigationBarDrawer(displayMode: .always))
    }
    
    var filterdpokemon: [PokemonDetail2] {
        if searchtext.isEmpty {
            return model.pokemonDetails2
        } else {
            return model.pokemonDetails2.filter {
                $0.jpname!.contains(searchtext) || $0.name.contains(searchtext) }
        }
    }
}


#Preview {
    PokemonListView()
}
