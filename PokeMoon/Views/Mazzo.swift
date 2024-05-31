//
//  Mazzo.swift
//  PokeMoon
//
//  Created by Massimo Donini on 07/06/23.
//

import SwiftUI

struct Mazzo: View {
    @StateObject private var vm = MazzoViewModel()
    

    var body: some View {
        VStack {
            ForEach(vm.carte, id: \.self) { carta in
                Text( "\(carta.pokemonIndex)")
                    .font(.largeTitle)
            }
        }
    }
}

struct Mazzo_Previews: PreviewProvider {
    static var previews: some View {
        Mazzo()
    }
}
