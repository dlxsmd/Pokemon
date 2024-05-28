//
//  NewsApiModel.swift
//  UpNews
//
//  Created by yuki on 2024/05/17.
//

import UIKit
import Alamofire
import Combine

class PokemonApiModel: ObservableObject {
    private let apiUrl:String = "https://pokeapi.co/api/v2/pokemon"

    public static let shared = PokemonApiModel()
    
    @Published var results:[Result] = []
    

    public func fetchData(params:PokemonParametersModel?,completion:@escaping([Result]) -> Void){
        
        AF.request(apiUrl,parameters:params)
            .responseData{ response in
                switch response.result {
                case .success(let data):
                    do {
                        let decoder = JSONDecoder()
                        let pokemonList = try decoder.decode(PokemonList.self, from: data)
                        DispatchQueue.main.async {
                            self.results = pokemonList.results
                            print(self.results)
                            completion(pokemonList.results)
                        }
                    } catch {
                        print("error: \(error)")
                    }
                case .failure(let error):
                    print("error: \(error)")
                }
            }
    }
    
    public func setPokemon(params:PokemonParametersModel?){
        fetchData(params:params){ info in
            DispatchQueue.main.async {
                self.results = info
            }
        }
    }
}
