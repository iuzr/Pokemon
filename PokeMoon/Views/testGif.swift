//
//  testGif.swift
//  PokeMoon
//
//  Created by Massimo Donini on 24/04/23.
//

import SwiftUI
import SwiftyGif

struct testGif: View {
    let url=URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-v/black-white/animated/shiny/1.gif");
    
    var body: some View {
        AnimatedGifView(url: Binding(get: { url! }, set: { _ in }))
    }
}

struct testGif_Previews: PreviewProvider {
    static var previews: some View {
        testGif()
    }
}

struct AnimatedGifView: UIViewRepresentable {
    @Binding var url: URL

    func makeUIView(context: Context) -> UIImageView {
        let imageView = UIImageView(gifURL: self.url)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }

    func updateUIView(_ uiView: UIImageView, context: Context) {
        uiView.setGifFromURL(self.url)
    }
}
