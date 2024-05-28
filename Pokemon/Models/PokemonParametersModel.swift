//
//  PokemonParametersModel.swift
//  Pokemon
//
//  Created by yuki on 2024/05/27.
//

import Foundation

struct PokemonParametersModel:Codable{
    let limit: Int?
    let offset: Int?
    init(limit:Int? = nil,offset:Int? = nil){
        self.limit = limit
        self.offset = offset
    }
}
