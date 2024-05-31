//
//  PokemonDetailView.swift
//  Pokemon
//
//  Created by yuki on 2024/05/28.
//

import SwiftUI

struct PokemonDetailView: View {
    @ObservedObject var model = PokemonApiModelTest2.shared
    let pokemonDetail: PokemonDetail
    @State var isShiny = false
    
    var body: some View {
        
        NavigationStack{
            HStack{
                //  Spacer()
                VStack{
                    if pokemonDetail.sprites.frontShiny != nil{
                        AsyncImage(url: URL(string: isShiny ? pokemonDetail.sprites.frontShiny! :pokemonDetail.sprites.frontDefault!)){ image in
                            image.resizable()
                                .frame(width: 200, height: 200)
                                .aspectRatio(contentMode: .fit)
                                .onTapGesture {
                                    isShiny.toggle()
                                }
                        }placeholder: {
                            ProgressView()
                        }.frame(width: 60, height: 60)
                    }else if pokemonDetail.sprites.frontDefault != nil{
                        AsyncImage(url: URL(string:pokemonDetail.sprites.frontDefault!)){ image in
                            image.resizable()
                                .frame(width: 200, height: 200)
                                .aspectRatio(contentMode: .fit)
                        }placeholder: {
                            ProgressView()
                        }.frame(width: 60, height: 60)
                    }else{
                        Rectangle()
                            .fill(.gray)
                            .frame(width: 100, height: 100)
                    }
                }.padding(45)
                
                
                
                VStack{
                    if let jpname = model.pokemonDetails2.first(where: { $0.id == pokemonDetail.id })?.names.first(where: { $0.language.name == "ja-Hrkt" }) {
                        Text(jpname.name)
                            .font(.custom("PKMN-REGULAR", size: 50))
                            .bold()
                    }else if let enname = model.pokemonDetails2.first(where: { $0.id == pokemonDetail.id })?.names.first(where: { $0.language.name == "en" }) {
                        Text(enname.name)
                            .font(.custom("PKMN-REGULAR", size: 50))
                            .bold()
                    }
                    Text("おもさ: \(String(format:"%.1f",Double(pokemonDetail.weight)/10.0))Kg")
                        .font(.custom("PKMN-REGULAR", size: 30))
                    Text("たかさ: \(String(format:"%.1f",Double(pokemonDetail.height)/10.0))m")
                        .font(.custom("PKMN-REGULAR", size: 30))
                }
            }
            if let flavorTextEntry = model.pokemonDetails2.first(where: { $0.id == pokemonDetail.id })?.flavorTextEntries.first(where: { $0.language.name == "ja-Hrkt" }) {
                Text(flavorTextEntry.flavorText)
                    .font(.custom("PKMN-REGULAR", size: 35))
                    .padding()
            }
        }.navigationTitle("No.\(String(format: "%03d",pokemonDetail.id))")
    }
}

