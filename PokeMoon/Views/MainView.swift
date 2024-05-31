//
//  ContentView.swift
//  PokeMoon
//
//  Created by Massimo Donini on 15/04/23.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            PokemonList()
                .tabItem {
                    Label("Pokemon", systemImage: "fossil.shell")
                }
            Text("Mazzo")
                .tabItem {
                    Label("Mazzo", systemImage: "list.clipboard")
                }
            Settings()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
