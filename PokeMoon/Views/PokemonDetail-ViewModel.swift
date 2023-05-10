//
//  PokemonDetail-ViewModel.swift
//  PokeMoon
//
//  Created by Massimo Donini on 01/05/23.
//

import Foundation

extension PokemonDetail {
    @MainActor class Vm: ObservableObject {
        @Published private (set) var itemsDetail: [ItemDetail] = []
        
        func getPokemonItem(itemUrl: String) async {
            if(!self.itemsDetail.isEmpty) { return }
            
            guard let url = URL(string: itemUrl) else {
                print("\(itemUrl) is not a valid URL")
                return
            }
            let data: Data
            do{
                (data,_) = try await URLSession.shared.data(from: url)
                if let decodedData = try? JSONDecoder().decode(ItemDetail.self, from: data) {
                    /*return itemDetail*/
                    self.itemsDetail.append(decodedData)
                }
            } catch {
                print("Error fetching data")
            }
        }
        
        /// Gets pokemon details
        /// - Parameter pokemonUrl: endpoint url
        /// - Returns: pokemon detail model
        func getPokemonDetailData(pokemonUrl: String) async throws -> PokemonDetailData?{
            guard let url = URL(string: pokemonUrl) else {
                print("url non valido")
                return nil
            }
            print("url okkk")
            let urlRequest = URLRequest(url: url)
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            print("request okkk!")
            guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error while fetching data in getPokemonDetailData") }
            let decodedData = try JSONDecoder().decode(PokemonDetailData.self, from: data)
            // print(decodedData)
            return decodedData
        }
    }
}
