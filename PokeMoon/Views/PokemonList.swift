//
//  PokemonList.swift
//  PokeMoon
//
//  Created by Massimo Donini on 15/04/23.
//

import SwiftUI

struct PokemonList: View {
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                // FIXME: Se scrollo velocemente non carica le foto e se clicco va in errore
                Text("\(viewModel.searchText.isEmpty ? viewModel.pokemons.count :  viewModel.filterPokemons().count) found")
                ForEach(viewModel.filterPokemons()) { pokemon in
                    NavigationLink (destination: PokemonDetail(pokemonUrl: pokemon.url)) {
                        PokemonItem(pokemon: pokemon)
                            .onAppear{
                                Task{
                                    try await viewModel.setPokemonImg(pokemonUrl: pokemon.url, pokemon: pokemon)
                                }
                            }
                            .environmentObject(viewModel)
                    }
                }
                ProgressView().progressViewStyle(.circular)
                    .task {
                        viewModel.limit += 20
                        print("now limit is \(viewModel.limit)")
                    }
            }
            .navigationTitle("Pokemon")
        }
        .searchable(text: $viewModel.searchText, prompt: "Cerca pokemon")
        .task {
            if(viewModel.pokemons.count == 0) {
                do {
                    try await viewModel.cachesAllPokemons()
                } catch {
                    print("Errore")
                }
            }
        }
    }
}

@MainActor
struct PokemonItem: View {
    @EnvironmentObject var viewModel: ViewModel
    var pokemon: Pokemon
    
    var body: some View {
        HStack {
            // FIXME: Not all images are rendered
            if let img = pokemon.image {
                AsyncImage(url: URL(string: img), scale: 2) { image in image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 70, height: 70)
                        .clipped()
                } placeholder: { ProgressView().progressViewStyle(.circular) }
            }
            // Spacer()
            VStack {
                Text(pokemon.name.capitalized)
                    .font(.title)
                .frame(maxWidth: .infinity, alignment: .leading)
                Text(pokemon.url)
                    .font(.footnote)
            }
        }
    }
}

struct PokemonList_Previews: PreviewProvider {
    static var previews: some View {
        PokemonList()
    }
}

