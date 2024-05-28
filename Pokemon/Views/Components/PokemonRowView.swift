//
//  PokemonRowView.swift
//  Pokemon
//
//  Created by yuki on 2024/05/28.
//

import SwiftUI

struct PokemonRowView: View {
    let pokemonDetail: PokemonDetail
    var body: some View {
        HStack{
                ZStack{
                    
                    Circle()
                        .fill(.gray)
                        .frame(width: 100, height: 100)
                   
                    AsyncImage(url: URL(string: pokemonDetail.sprites.frontDefault)){ image in
                        image.resizable()
                            .frame(width: 100, height: 100)
                            .aspectRatio(contentMode: .fill)
                    }placeholder: {
                        ProgressView()
                    }.frame(width: 60, height: 60)
                }
            Text("No.\(String(format: "%03d",pokemonDetail.id))")
            
            Spacer()
            
            Text(pokemonDetail.name)
                .font(.title3)
                .bold()
            
            Spacer()
        }
    }
}

#Preview {
    PokemonRowView(pokemonDetail: PokemonDetail(abilities: [Ability(ability: Species(name: "Static", url: "https://pokeapi.co/api/v2/ability/9/"), isHidden: false, slot: 3)], baseExperience: 112, forms: [Species(name: "pikachu", url: "https://pokeapi.co/api/v2/pokemon-species/25/")], height: 4, id: 25, name: "pikachu", order: 35, species: Species(name: "pikachu", url: "https://pokeapi.co/api/v2/pokemon-species/25/"), sprites: Sprites(backDefault: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/25.png", backShiny: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/25.png", frontDefault: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/25.png", frontShiny: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/25.png", animated: nil), weight: 60))
}
