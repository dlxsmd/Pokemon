//
//  PokemonApiModelTest2.swift
//  Pokemon
//
//  Created by yuki on 2024/05/29.
//

import UIKit
import Alamofire
import Combine
import Dispatch

class PokemonApiModel: ObservableObject {
    public static let shared = PokemonApiModel()
    
    @Published var pokemonDetails: [PokemonDetail] = []
    @Published var pokemonDetails2: [PokemonDetail2] = []
    @Published var results: [Result] = []
    @Published var fetchcount = 0
    
    public func fetchPokemonList(params: PokemonParametersModel?, completion: @escaping ([Result]) -> Void) {
        let pokemonListUrl = "https://pokeapi.co/api/v2/pokemon"
        AF.request(pokemonListUrl, parameters: params)
            .responseDecodable(of: PokemonList.self) { response in
                switch response.result {
                case .success(let pokemonList):
                    DispatchQueue.main.async {
                        self.results = pokemonList.results
                        print(self.results)
                        let group = DispatchGroup()
                        for pokemon in self.results{
                            group.enter()
                            self.fetchPokemonDetails(pokemon: pokemon){
                                group.leave()
                            }
                            group.enter()
                            self.fetchPokemonDetails2(pokemon: pokemon){
                                group.leave()
                            }
                        }
                        group.notify(queue: .main) {
                            print("Fetched all Pokemon details.")
                            self.fetchcount = 1025
                            completion(pokemonList.results)
                        }
                    }
                case .failure(let error):
                    print("Request error: \(error)")
                }
            }
    }
    
    func fetchPokemonDetails(pokemon: Result, completion: @escaping () -> Void) {
        if self.pokemonDetails.contains(where: { $0.name == pokemon.name }) {
                    completion()
                    return
                }
        let pokemonDetailUrl = "https://pokeapi.co/api/v2/pokemon/\(pokemon.name)"
        print("Fetching details for: \(pokemon.name) from \(pokemonDetailUrl)")

        AF.request(pokemonDetailUrl).responseDecodable(of: PokemonDetail.self) { response in
            switch response.result {
            case .success(let pokemonDetail):
                DispatchQueue.main.async {
                    if !self.pokemonDetails.contains(where: { $0.id == pokemonDetail.id }) {
                        self.pokemonDetails.append(pokemonDetail)
                        print("Fetched details for \(pokemon.name): \(pokemonDetail)")
                    }
                    completion()
                }
            case .failure(let error):
                print("Failed to fetch details for \(pokemon.name): \(error.localizedDescription)")
                completion()
            }
        }
    }

    func fetchPokemonDetails2(pokemon: Result, completion: @escaping () -> Void) {
        if self.pokemonDetails2.contains(where: { $0.name == pokemon.name }) {
                    completion()
                    return
                }
        let pokemonDetail2Url = "https://pokeapi.co/api/v2/pokemon-species/\(pokemon.name)"
        print("Fetching details for: \(pokemon.name) from \(pokemonDetail2Url)")

        AF.request(pokemonDetail2Url).responseDecodable(of: PokemonDetail2.self) { response in
            switch response.result {
            case .success(let pokemonDetail2):
                DispatchQueue.main.async {
                    let jpname = pokemonDetail2.names.first(where: { $0.language.name == "ja" })?.name
                    var updatedPokemonDetail2 = pokemonDetail2
                    updatedPokemonDetail2.jpname = jpname
                    self.pokemonDetails2.append(updatedPokemonDetail2)
                    self.fetchcount += 1
                    completion()
                }
            case .failure(let error):
                print("Failed to fetch details for \(pokemon.name): \(error.localizedDescription)")
                completion()

            }
        }
    }

    
    public func setPokemon(params: PokemonParametersModel?) {
        fetchPokemonList(params: params) { info in
            DispatchQueue.main.async {
                self.results = info
            }
        }
    }
    
    public func progress() -> Float {
        let total: Float = 1025
        let fetched: Float = Float(fetchcount)
        return fetched / total
    }
}
