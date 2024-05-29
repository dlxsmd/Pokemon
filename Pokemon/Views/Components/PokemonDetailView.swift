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
                            .frame(width: 200, height: 200)
                    }
                }.padding(45)
                
                
                
                VStack{
                    Text(pokemonDetail.name)
                        .font(.title2)
                        .bold()
                    Text("Weight: \(pokemonDetail.weight/10)Kg")
                    Text("Height: \(String(format:"%.1f",Double(pokemonDetail.height)/10.0))m")
                }
              //  Spacer()
            }
            
            .navigationTitle("No.\(String(format: "%03d",pokemonDetail.id))")
        }
    }
}


