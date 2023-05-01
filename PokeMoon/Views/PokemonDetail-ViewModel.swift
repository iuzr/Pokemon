//
//  PokemonDetail-ViewModel.swift
//  PokeMoon
//
//  Created by Massimo Donini on 01/05/23.
//

import Foundation

extension PokemonDetail {
    @MainActor class Vm: ObservableObject {
        @Published private (set) var pokemon = PokemonDetailData()
        @Published private (set) var itemsDetail: [ItemDetail] = []
    }
}
