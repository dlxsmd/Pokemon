//
//  PokemonApiModelTest2.swift
//  Pokemon
//
//  Created by yuki on 2024/05/29.
//

import UIKit
import Alamofire
import Combine

class PokemonApiModelTest2: ObservableObject {
    public static let shared = PokemonApiModelTest2()
    
    @Published var pokemonDetails: [PokemonDetail] = []
    @Published var pokemonDetails2: [PokemonDetail2] = []
    @Published var results: [Result] = []
    
    public func fetchPokemonList(params: PokemonParametersModel?, completion: @escaping ([Result]) -> Void) {
        let pokemonListUrl = "https://pokeapi.co/api/v2/pokemon"
        AF.request(pokemonListUrl, parameters: params)
            .responseDecodable(of: PokemonList.self) { response in
                switch response.result {
                case .success(let pokemonList):
                    DispatchQueue.main.async {
                        self.results = pokemonList.results
                        print(self.results)
                        self.fetchPokemonDetails(pokemons: self.results)
                        self.fetchPokemonDetails2(pokemons: self.results)
                        completion(pokemonList.results)
                    }
                case .failure(let error):
                    print("Request error: \(error)")
                }
            }
    }
    
    func fetchPokemonDetails(pokemons: [Result], currentIndex: Int = 0) {
        if currentIndex >= pokemons.count {
            print("Fetched all Pokemon details.")
            return
        }

        let pokemon = pokemons[currentIndex]
        let pokemonDetailUrl = "https://pokeapi.co/api/v2/pokemon/\(pokemon.name)"
        print("Fetching details for: \(pokemon.name) from \(pokemonDetailUrl)")

        AF.request(pokemonDetailUrl).responseDecodable(of: PokemonDetail.self) { response in
            switch response.result {
            case .success(let pokemonDetail):
                DispatchQueue.main.async {
                    self.pokemonDetails.append(pokemonDetail)
                    print("Fetched details for \(pokemon.name): \(pokemonDetail)")
                }
                self.fetchPokemonDetails(pokemons: pokemons, currentIndex: currentIndex + 1)
            case .failure(let error):
                print("Failed to fetch details for \(pokemon.name): \(error.localizedDescription)")
            }
        }
    }

    func fetchPokemonDetails2(pokemons: [Result], currentIndex: Int = 0) {
        if currentIndex >= pokemons.count {
            print("Fetched all Pokemon details.")
            return
        }

        let pokemon = pokemons[currentIndex]
        let pokemonDetail2Url = "https://pokeapi.co/api/v2/pokemon-species/\(pokemon.name)"
        print("Fetching details for: \(pokemon.name) from \(pokemonDetail2Url)")

        AF.request(pokemonDetail2Url).responseDecodable(of: PokemonDetail2.self) { response in
            switch response.result {
            case .success(let pokemonDetail2):
                DispatchQueue.main.async {
                    self.pokemonDetails2.append(pokemonDetail2)
                    print("Fetched details for \(pokemon.name): \(pokemonDetail2)")
                }
                self.fetchPokemonDetails2(pokemons: pokemons, currentIndex: currentIndex + 1)
            case .failure(let error):
                print("Failed to fetch details for \(pokemon.name): \(error.localizedDescription)")
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
}
