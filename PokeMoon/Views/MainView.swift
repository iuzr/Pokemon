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
                    Label("Pokemon", systemImage: "teddybear")
                }
            Text("Map")
                .tabItem {
                    Label("Map", systemImage: "globe.europe.africa")
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
