//
//  PokemonDetail.swift
//  PokeMoon
//
//  Created by Massimo Donini on 15/04/23.
//

import SwiftUI

struct PokemonDetail: View {
    @StateObject private var vm = Vm()
    @State var hint : String = ""
    @State var showHint = false
    
    var body: some View {
        VStack {
            Text(vm.pokemon.name.capitalized)
                .bold()
                .font(.title)
            PokemonCarousel(pokemon: vm.pokemon)
            HStack {
                Label(String("\(vm.pokemon.height*10) cm"),systemImage: "ruler")
                    .foregroundColor(.blue)
                    .bold()
                    .font(.system(size: 20))
                    .onTapGesture {
                        hint = "Altezza di \(vm.pokemon.name.capitalized)"
                        showHint = true
                    }
                    .alert(hint, isPresented: $showHint){
                        Button("OK", role: .cancel) {}
                    }
                Spacer()
                Label(String(format: "%.0f Kg",Float(vm.pokemon.weight)/10),systemImage: "scalemass")
                    .foregroundColor(.red)
                    .bold()
                    .font(.system(size: 20))
                    .onTapGesture {
                        hint = "Peso di \(vm.pokemon.name.capitalized)"
                        showHint = true
                    }
                Spacer()
                Label(String("\(vm.pokemon.baseExperience) Exp"),systemImage: "hand.thumbsdown")
                    .foregroundColor(.green)
                    .bold()
                    .font(.system(size: 20))
                    .onTapGesture {
                        hint = "Punti esperienza che guadagni se sconfiggi  \(vm.pokemon.name.capitalized)"
                        showHint = true
                    }
            }
            .padding(.vertical)
            Spacer()
            Text(vm.itemsDetail.count > 0 ? "Oggetti posseduti" : "Nessun oggetto posseduto")
                .font(.title2)
                .bold()
            ItemsCarousel(itemsDetail: vm.itemsDetail)
            Spacer()
            HStack(){
                Image(systemName: "arrow.left.circle")
                    .font(.system(size: 60))
                    .shadow(color: .gray, radius: 5, x: 5, y: 5)
                Spacer()
                Image(systemName: "arrow.right.circle")
                    .font(.system(size: 60))
                    .shadow(color: .gray, radius: 5, x: 5, y: 5)
            }
        }
        .padding()
        .task {
            do {
                print("pokemonDetail onappearing")
                for item in vm.pokemon.heldItems {
                    await getPokemonItem(itemUrl: item.item.url)
                }
            }
        }
    }
    
    func getPokemonItem(itemUrl: String) async {
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

struct PokemonCarousel: View {
    let pokemon : PokemonDetailData
    
    var body: some View {
        VStack{
            TabView {
                PokemonAnimatedGif(urlString: pokemon.sprites.versions?.generationV.blackWhite.animated?.frontDefault ?? pokemon.sprites.frontDefault)
                PokemonAnimatedGif(urlString: pokemon.sprites.versions?.generationV.blackWhite.animated?.backDefault ?? pokemon.sprites.backDefault)
                PokemonAnimatedGif(urlString: pokemon.sprites.versions?.generationV.blackWhite.animated?.frontShiny ?? pokemon.sprites.frontShiny)
                PokemonAnimatedGif(urlString: pokemon.sprites.versions?.generationV.blackWhite.animated?.backShiny ?? pokemon.sprites.backShiny)
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
        PokemonDetail(pokemon: PokemonDetailData.samplePokemon)
    }
}


