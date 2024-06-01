//
//  LoadingView.swift
//  Pokemon
//
//  Created by yuki on 2024/06/01.
//

import SwiftUI

struct LoadingView: View {
    @ObservedObject var model = PokemonApiModel.shared
    var body: some View {
        
        if model.progress() < 1 {
            VStack{
                Text("LoadingPokemon...")
                    .font(.title)
                    .bold()
                ZStack {
                    Circle()
                        .stroke(
                            .gray,
                            style: StrokeStyle(
                                lineWidth: 15,
                                lineCap: .round)
                        )
                        .opacity(0.5)
                        .frame(width: 150, height: 150)
                    Circle()
                        .trim(from: 0.0, to: CGFloat(model.progress()))
                        .stroke(
                            .red,
                            style: StrokeStyle(
                                lineWidth: 15,
                                lineCap: .round)
                        )
                        .frame(width: 150, height: 150)
                        .rotationEffect(Angle(degrees: -90))
                    Text("\(Int(model.progress() * 100))%")
                        .font(.title)
                        .bold()
                }
            }
            .onAppear{
                model.setPokemon(params: PokemonParametersModel(limit: 1025, offset: 0))
            }
        }else if model.progress() >= 1{
            PokemonListView()
        }
    }
}


#Preview {
    LoadingView()
}
