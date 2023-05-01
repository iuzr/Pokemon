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
                Text("\(viewModel.totalPokemons) found")
                ForEach(viewModel.pokemons.sorted{$0.id < $1.id}) { pokemon in
                    NavigationLink (destination: PokemonDetail(pokemon: pokemon)) {
                        PokemonItem(pokemon: pokemon)
                        /*.onAppear {
                         // print("onappear")
                         Task{
                         await viewModel.loadMorePokemon(pokemon: pokemon)
                         }
                         }*/
                    }
                }
                if(viewModel.page < viewModel.totalPages ){
                    ProgressView().progressViewStyle(.circular)
                        .onAppear{
                            Task{
                                viewModel.page += 1
                                try? await viewModel.fetchData()
                            }
                        }
                }
            }
            .navigationTitle("Pokemon")
        }
        .task {
            print("appearing task")
            if(viewModel.pokemons.count == 0) {
                do {
                    try await viewModel.fetchData()
                } catch {
                    print("Errore")
                }
            }
        }
    }
}

struct PokemonItem: View {
    let pokemon: PokemonDetailData
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: pokemon.sprites.frontDefault), scale: 2) { image in image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 70, height: 70)
                    .clipped()
            } placeholder: { ProgressView().progressViewStyle(.circular) }
            // Spacer()
            Text(pokemon.name.capitalized + " (\(pokemon.id))")
                .font(.title)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

struct PokemonList_Previews: PreviewProvider {
    static var previews: some View {
        PokemonList()
    }
}

