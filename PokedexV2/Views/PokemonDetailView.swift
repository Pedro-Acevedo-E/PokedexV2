//
//  PokemonDetailView.swift
//  PokedexV2
//
//  Created by Pedro Acevedo on 05/06/24.
//

import SwiftUI

struct PokemonDetailView: View {
    let pokemonId: Int
    
    var body: some View {
        Text("Details for: " + String(pokemonId))
    }
    
    init(pokemonId: Int) {
        self.pokemonId = pokemonId
        print("View \(String(pokemonId)) is built")
    }
}

#Preview {
    PokemonDetailView(pokemonId: 1)
}
