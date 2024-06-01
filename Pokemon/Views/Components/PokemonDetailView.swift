//
//  PokemonDetailView.swift
//  Pokemon
//
//  Created by yuki on 2024/05/28.
//

import SwiftUI
import UIKit

struct PokemonDetailView: View {
    let pokemonDetail: PokemonDetail
    let pokemonDetail2: PokemonDetail2
    @State var isShiny = false
    
    var body: some View {
        
                    ZStack{
                Image("pokedex")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .aspectRatio(contentMode: .fill)

                               
                VStack{
                    HStack{
                        VStack{
                            if pokemonDetail.sprites.frontShiny != nil{
                                AsyncImage(url: URL(string: isShiny ? pokemonDetail.sprites.frontShiny! :pokemonDetail.sprites.frontDefault!)){ image in
                                    image.resizable()
                                        .frame(width: 150, height: 150)
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
                                        .frame(width: 150, height: 150)
                                        .aspectRatio(contentMode: .fit)
                                }placeholder: {
                                    ProgressView()
                                }.frame(width: 60, height: 60)
                            }else{
                                Rectangle()
                                    .fill(.gray)
                                    .frame(width: 70, height: 70)
                            }
                        }.padding()
                        
                        
                        
                        VStack{
                            if let jpname = pokemonDetail2.names.first(where: { $0.language.name == "ja-Hrkt" }) {
                                Text(jpname.name)
                                    .font(.custom("PKMN-REGULAR", size: 40))
                                    .bold()
                            }else if let enname = pokemonDetail2.names.first(where: { $0.language.name == "en" }) {
                                Text(enname.name)
                                    .font(.custom("PKMN-REGULAR", size: 50))
                                    .bold()
                            }
                            Text("おもさ: \(String(format:"%.1f",Double(pokemonDetail.weight)/10.0))Kg")
                                .font(.custom("PKMN-REGULAR", size: 20))
                            Text("たかさ: \(String(format:"%.1f",Double(pokemonDetail.height)/10.0))m")
                                .font(.custom("PKMN-REGULAR", size: 20))
                        }.padding(.leading,10)
                    }
                    if let flavorTextEntry = pokemonDetail2.flavorTextEntries.first(where: { $0.language.name == "ja-Hrkt" }) {
                        Text(flavorTextEntry.flavorText)
                            .font(.custom("PKMN-REGULAR", size: 30))
                            .padding(.horizontal,5)
                            .padding(.top,5)
                    }
                }.frame(width: 250, height: 300)
                    .offset(x:10,y: -150)
            }
                    .navigationTitle("No.\(String(format: "%03d",pokemonDetail.id))")
        }
    }


#Preview {
    PokemonDetailView(pokemonDetail: PokemonDetail(height: 10, id: 1, sprites: Sprites(frontDefault: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png", frontShiny: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/1.png"), weight: 10, name: "bulbasaur"), pokemonDetail2: PokemonDetail2(color: Color(name: "green", url: "https://pokeapi.co/api/v2/pokemon-color/5/"), flavorTextEntries: [FlavorTextEntry(flavorText: "うまれたときから　せなかに　ふしぎな　タネが　うえてあって　からだと　ともに　そだつという。", language: Color(name: "ja-Hrkt", url: "https://pokeapi.co/api/v2/language/1/"))], id: 1, name: "bulbasaur", names: [Name(language: Color(name: "ja-Hrkt", url: "https://pokeapi.co/api/v2/language/1/"), name: "フシギダネ")]))
}
