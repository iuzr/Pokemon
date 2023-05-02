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
        
    }
}
