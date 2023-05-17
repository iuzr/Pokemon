//
//  PokemonDetail.swift
//  PokeMoon
//
//  Created by Massimo Donini on 15/04/23.
//

import SwiftUI

struct PokemonDetail: View {
    @StateObject private var vm = Vm()
    
    @State var pokemon: PokemonDetailData?
    @State var hint : String = ""
    @State var showHint = false
    
    let pokemonUrl : String
    
    var body: some View {
        NavigationView {
            VStack {
                if let pokemon = pokemon {
                    /*Text(pokemon.name.capitalized)
                        .bold()
                        .font(.title)*/
                    PokemonCarousel(pokemon: pokemon)
                    HStack {
                        Label(String("\(pokemon.height*10) cm"),systemImage: "ruler")
                            .foregroundColor(.blue)
                            .bold()
                            .font(.system(size: 20))
                            .onTapGesture {
                                hint = "Altezza di \(pokemon.name.capitalized)"
                                showHint = true
                            }
                            .alert(hint, isPresented: $showHint){
                                Button("OK", role: .cancel) {}
                            }
                        Spacer()
                        Label(String(format: "%.0f Kg",Float(pokemon.weight)/10),systemImage: "scalemass")
                            .foregroundColor(.red)
                            .bold()
                            .font(.system(size: 20))
                            .onTapGesture {
                                hint = "Peso di \(pokemon.name.capitalized)"
                                showHint = true
                            }
                        Spacer()
                        Label(String("\(pokemon.baseExperience ?? 0) Exp"),systemImage: "hand.thumbsdown")
                            .foregroundColor(.green)
                            .bold()
                            .font(.system(size: 20))
                            .onTapGesture {
                                hint = "Punti esperienza che guadagni se sconfiggi  \(pokemon.name.capitalized)"
                                showHint = true
                            }
                    }
                    .padding(.vertical)
                    Spacer()
                    NavigationLink(destination: PokemonStats(pokemon: pokemon)){
                        Text("Stats")
                            .padding()
                            .font(.title2)
                            .foregroundColor(.white)
                            .background(Color.accentColor)
                            .cornerRadius(15)
                    }
                    Spacer()
                    Text(vm.itemsDetail.count > 0 ? "Oggetti posseduti" : "Nessun oggetto posseduto")
                        .font(.title2)
                        .bold()
                    ItemsCarousel(itemsDetail: vm.itemsDetail)
                    Spacer()
                } else {
                    Text("Not found")
                }
            }
            .navigationTitle(pokemon?.name.capitalized ?? "")
            .padding()
            .task {
                do {
                    print("pokemonDetail onappearing for \(pokemonUrl)")
                    pokemon = try await vm.getPokemonDetailData(pokemonUrl: pokemonUrl)
                    
                    if let pokemon = pokemon {
                        for item in pokemon.heldItems {
                            await vm.getPokemonItem(itemUrl: item.item.url)
                        }
                    }
                } catch {
                    print("catch error")
                }
        }
        }
    }
}

struct PokemonCarousel: View {
    let pokemon : PokemonDetailData
    
    var body: some View {
        VStack{
            TabView {
                if let img = pokemon.sprites.versions?.generationV.blackWhite.animated?.frontDefault {
                    PokemonAnimatedGif(urlString: img)
                } else {
                    PokemonStaticGif(pokemon: pokemon)
                }
                if let img = pokemon.sprites.versions?.generationV.blackWhite.animated?.backDefault {
                    PokemonAnimatedGif(urlString: img)
                }
                if let img = pokemon.sprites.versions?.generationV.blackWhite.animated?.frontShiny {
                    PokemonAnimatedGif(urlString: img )
                }
                if let img = pokemon.sprites.versions?.generationV.blackWhite.animated?.backShiny {
                    PokemonAnimatedGif(urlString: img)
                }
            }
            .tabViewStyle(.page)
        }
        .frame(height: 200)
    }
}

struct ItemsCarousel: View {
    let itemsDetail: [ItemDetail]
    
    var body: some View {
        ScrollView(.horizontal){
            HStack {
                ForEach(itemsDetail) { item in
                    VStack {
                        AsyncImage(url: URL(string: item.sprites.default), scale: 2) { image in image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 90, height: 90)
                                .clipped()
                        } placeholder: { ProgressView().progressViewStyle(.circular) }
                        Text(item.name)
                            .bold()
                            .font(.title3)
                            .frame(maxWidth: .infinity)
                        HStack{
                            Image(systemName: "eurosign.circle.fill")
                                .foregroundColor(.yellow)
                                .font(.system(size: 25))
                            Text(String(item.cost))
                        }
                    }
                    .frame(width: 120)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.purple, lineWidth: 1)
                    )
                }
                
            }
        }
    }
}

struct PokemonStaticGif: View {
    let pokemon: PokemonDetailData
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.mint)
                .frame(width: 200, height: 200)
                .cornerRadius(100)
            .padding()
            if let img = pokemon.sprites.frontDefault {
                AsyncImage(url: URL(string: img), scale: 2) { image in image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 170, height: 170)
                        .clipped()
                } placeholder: { ProgressView().progressViewStyle(.circular) }
            }
        }
    }
}

struct PokemonAnimatedGif: View{
    let urlString : String?
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.mint)
                .frame(width: 200, height: 200)
                .cornerRadius(100)
            .padding()
            AnimatedGifView(url: Binding(get: { URL(string: urlString!)! }, set: { _ in }))
                .frame(width: 100, height: 100)
            .clipped()
        }
    }
}

struct HeldItems: View {
    var body: some View {
        Text("test")
    }
}

struct PokemonDetail_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDetail(pokemonUrl : "https://pokeapi.co/api/v2/pokemon/1004/")
    }
}


