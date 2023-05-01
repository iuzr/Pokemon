//
//  PokemonList-ViewModel.swift
//  PokeMoon
//
//  Created by Massimo Donini on 30/04/23.
//

import Foundation

extension PokemonList {
    @MainActor class ViewModel: ObservableObject {
        @Published private (set) var pokemons: [PokemonDetailData]=[]
        @Published private (set) var totalPokemons = 0
        
        var page: Int = 0
        var totalPages: Int = 0
        let maxPokemons: Int = 20
        
        func fetchData() async throws{
            //Parse URL
            guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=\(self.maxPokemons)&offset=\(self.page*self.maxPokemons)") else { fatalError("Url not valid") }
            let urlRequest = URLRequest(url: url)
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error while fetching data in fetchData") }
            // print(data)
            let decodedData = try JSONDecoder().decode(Welcome.self, from: data)
            self.totalPokemons = decodedData.count
            self.totalPages = self.totalPokemons / self.maxPokemons + 1
            // print(decodedData)
            for pokemon in decodedData.results {
                // print(pokemon.name)
                if let detail = try? await getPokemonDetailData(pokemonUrl: pokemon.url) {
                    self.pokemons.append(detail)
                }
            }
        }

        func getPokemonDetailData(pokemonUrl: String) async throws -> PokemonDetailData?{
            guard let url = URL(string: pokemonUrl) else { return nil}
            let urlRequest = URLRequest(url: url)
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error while fetching data in getPokemonDetailData") }
            let decodedData = try JSONDecoder().decode(PokemonDetailData.self, from: data)
            // self.pokemons.append(decodedData)
            return decodedData
        }
    }
}