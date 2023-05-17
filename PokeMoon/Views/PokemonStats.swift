//
//  PokemonStats.swift
//  PokeMoon
//
//  Created by Massimo Donini on 17/05/23.
//

import SwiftUI

struct PokemonStats: View {
    let pokemon: PokemonDetailData
    
    var body: some View {
        
        // FIXME: layout troppo in basso
        
        VStack {
            Text("Stats")
                .font(.title)
            VStack {
                ForEach(pokemon.stats) { stat in
                    VStack {
                        Text(stat.stat.name)
                            .font(.title2)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .offset(y:8)
                        ZStack {
                            ProgressView(value: (Float(stat.baseStat) / 100.0))
                                .tint(.green)
                                .scaleEffect(x: 1, y: 9, anchor: .center)
                            //.offset(y: 20)
                            Text(String(stat.baseStat))
                                .font(.title3)
                                //.frame(maxWidth: 100, alignment: .center)
                            //.background(.yellow)
                        }
                    }
                    .padding(.leading)
                    .padding(.trailing)
                }
            }
        }
    }
}

struct PokemonStats_Previews: PreviewProvider {
    
    static var previews: some View {
        PokemonStats(pokemon: PokemonDetailData.samplePokemon)
    }
}
