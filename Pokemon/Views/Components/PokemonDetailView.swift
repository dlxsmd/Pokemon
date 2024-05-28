//
//  PokemonDetailView.swift
//  Pokemon
//
//  Created by yuki on 2024/05/28.
//

import SwiftUI

struct PokemonDetailView: View {
    let pokemonDetail: PokemonDetail
    @State var isShiny = false
    var body: some View {
        NavigationStack{
            AsyncImage(url: URL(string: isShiny ? pokemonDetail.sprites.frontShiny :pokemonDetail.sprites.frontDefault)){ image in
                image.resizable()
                    .frame(width: 200, height: 200)
                    .aspectRatio(contentMode: .fit)
                    .padding(.bottom,80)
                    .onTapGesture {
                        isShiny.toggle()
                    }
            }placeholder: {
                ProgressView()
            }.frame(width: 60, height: 60)
            
            Text(pokemonDetail.name)
                .font(.title2)
                .bold()
           
            .navigationTitle("No.\(String(format: "%03d",pokemonDetail.id))")
        }
    }
}

#Preview {
    PokemonDetailView(pokemonDetail:PokemonDetail(abilities: [Ability(ability: Species(name: "Static", url: "https://pokeapi.co/api/v2/ability/9/"), isHidden: false, slot: 3)], baseExperience: 112, forms: [Species(name: "pikachu", url: "https://pokeapi.co/api/v2/pokemon-species/25/")], height: 4, id: 25, name: "pikachu", order: 35, species: Species(name: "pikachu", url: "https://pokeapi.co/api/v2/pokemon-species/25/"), sprites: Sprites(backDefault: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/25.png", backShiny: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/25.png", frontDefault: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/25.png", frontShiny: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/25.png", animated: nil), weight: 60))
}
