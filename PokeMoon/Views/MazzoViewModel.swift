//
//  MazzoViewModel.swift
//  PokeMoon
//
//  Created by Massimo Donini on 07/06/23.
//

import Foundation
import SwiftUI

@MainActor class MazzoViewModel : ObservableObject {
    @Published var carte: [Carta] = []
    
    @AppStorage("cardsNumber") var mazzoSize = 5
    
    init() {
        creaMazzo()
    }
    
    func creaMazzo() {
        if carte.isEmpty {
            for i in 1...mazzoSize {
                carte.append(Carta(pokemonIndex: i, value: Float(Int.random(in: 1...100))))
            }
        }
    }
}
