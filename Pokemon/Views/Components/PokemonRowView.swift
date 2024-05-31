//
//  PokemonRowView.swift
//  Pokemon
//
//  Created by yuki on 2024/05/28.
//

import SwiftUI

struct PokemonRowView: View {
    @ObservedObject var model = PokemonApiModelTest2.shared
    let pokemonDetail: PokemonDetail
    var body: some View {
        HStack{
            ZStack{
                
                Circle()
                    .fill(.gray)
                    .frame(width: 100, height: 100)
                
                if pokemonDetail.sprites.frontDefault != nil{
                    AsyncImage(url: URL(string: pokemonDetail.sprites.frontDefault!)){ image in
                        image.resizable()
                            .frame(width: 100, height: 100)
                            .aspectRatio(contentMode: .fill)
                    }placeholder: {
                        ProgressView()
                    }.frame(width: 60, height: 60)
                }
            }
            Text("No.\(String(format: "%03d",pokemonDetail.id))")
            
            Spacer()
            
            if let jpname = model.pokemonDetails2.first(where: { $0.id == pokemonDetail.id })?.names.first(where: { $0.language.name == "ja-Hrkt" || $0.language.name == "ja"}) {
                Text(jpname.name)
                    .font(.custom("PKMN-REGULAR", size: 30))
                    .bold()
                
                Spacer()
            }
        }
    }
}
