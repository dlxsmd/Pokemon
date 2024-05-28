import UIKit
import Alamofire
import Combine

class PokemonApiModelTest: ObservableObject {
    public static let shared = PokemonApiModelTest()
    
    @Published var pokemonDetail: PokemonDetail!
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
                    self.pokemonDetail = pokemonDetail
                    print("Fetched details for \(pokemon.name): \(pokemonDetail)")
                }
                self.fetchPokemonDetails(pokemons: pokemons, currentIndex: currentIndex + 1)
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
