//
//  PokemonList-ViewModel.swift
//  PokeMoon
//
//  Created by Massimo Donini on 30/04/23.
//

import Foundation

//extension PokemonList {
    @MainActor class ViewModel: ObservableObject {
        @Published private (set) var pokemons: [Pokemon] = []
        @Published private (set) var totalPokemons = 0
        @Published var searchText: String = ""
        @Published var limit = 20
        
        var page: Int = 0
        var totalPages: Int = 0
        let maxPokemons: Int = 20
        
        /// Gets maxPokemons items starting at offset (page x maxPokemons) from https://pokeapi.co/api/v2/pokemon and foreach item gets its detail.
        func fetchData() async throws{
//            print("list fetch data")
            //Parse URL
            guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=\(self.maxPokemons)&offset=\(self.page*self.maxPokemons)") else { fatalError("Url not valid") }
            print(url)
            let urlRequest = URLRequest(url: url)
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error while fetching data in fetchData") }
            // print(data)
            let decodedData = try JSONDecoder().decode(Welcome.self, from: data)
            self.totalPokemons = decodedData.count
            self.totalPages = self.totalPokemons / self.maxPokemons + 1
            var fetchedPokemons = decodedData.results
            // print(decodedData)
            for index in fetchedPokemons.indices {
                let url = fetchedPokemons[index].url
                // print(pokemon.name)
                if let detail = try? await getPokemonDetailData(pokemonUrl: url) {
                    // self.pokemons.append(detail)
                    fetchedPokemons[index].image = detail.sprites.frontDefault
                }
            }
            self.pokemons += fetchedPokemons
        }
        
        func filterPokemons() -> [Pokemon] {
            guard !searchText.isEmpty else {
                let maxLimit = limit > pokemons.count ? pokemons.count : limit
                return pokemons.count >= limit ? Array(pokemons[0...maxLimit]) : pokemons
            }
            return pokemons.filter { pokemon in
                pokemon.name.lowercased().starts(with: searchText.lowercased())
            }
        }

        func cachesAllPokemons() async throws {
            print("caches pokemons")
            guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=100000&offset=0") else { fatalError("Url not valid") }
            let urlRequest = URLRequest(url: url)
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error while fetching data in fetchData") }
            print(data)
            let decodedData = try JSONDecoder().decode(Welcome.self, from: data)
            // self.totalPokemons = decodedData.count
            // self.totalPages = self.totalPokemons / self.maxPokemons + 1
            pokemons = decodedData.results
        }
        
        /// Gets the image url from API and sets it
        /// - Parameters:
        ///   - pokemonUrl: API endpoint for the pokemon
        ///   - pokemon: pokemon where the image url has to be set
        func setPokemonImg(pokemonUrl: String, pokemon: Pokemon) async throws {
            if pokemon.image != nil || pokemon.image?.isEmpty == false {
                print("Image of \(pokemon.name) found")
                return
            }
            guard let index = pokemons.firstIndex(of: pokemon) else { return }
            
            print("setPokemonImg for \(pokemon.name)")
            guard let url = URL(string: pokemonUrl) else { fatalError("\(pokemonUrl) non è un url valido")}
            let urlRequest = URLRequest(url: url)
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error while fetching data in getPokemonDetailData") }
            let decodedData = try JSONDecoder().decode(PokemonDetailData.self, from: data)
            
            print("index for \(pokemon.name) is \(index)")
            pokemons[index].image = decodedData.sprites.frontDefault
        }

        
        /// Gets pokemon details
        /// - Parameter pokemonUrl: endpoint url
        /// - Returns: pokemon detail model
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
//}
