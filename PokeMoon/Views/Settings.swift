//
//  Settings.swift
//  PokeMoon
//
//  Created by Massimo Donini on 06/06/23.
//

import SwiftUI

struct Settings: View {
    @AppStorage("cardsNumber") private var cardsNumber = 5.0
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Generali")) {
                    VStack {
                        Text("Numero di carte: \(Int(cardsNumber))")
                        Slider(value: $cardsNumber,
                               in: 3...8,
                               step: 1.0) {
                            Text("Numero di carte")
                        }
                    minimumValueLabel: {
                        Text("3")
                    }
                    maximumValueLabel: {
                        Text("8")
                    }
                    }
                }
            }
        }
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
