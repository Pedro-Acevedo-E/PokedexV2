//
//  PokemonDetailView.swift
//  PokedexV2
//
//  Created by Pedro Acevedo on 05/06/24.
//

import SwiftUI

struct PokemonDetailView: View {
    let pokemonId: Int
    @State private var pokemon = PokemonDetailViewModel()
    
    var body: some View {
        VStack {
            Text("Details for: " + String(pokemonId))
            if let pkm = pokemon.pokemonDetail {
                Text("Decoded details for: \(pkm.name)")
            }
            if let pkm = pokemon.pokemonSpecies {
                Text("Decoded species details for: \(pkm.name)")
            }
        }
        .task {
            await pokemon.loadDetails(id: pokemonId)
            await pokemon.loadSpeciesDetails(id: pokemonId)
        }
    }
    
    init(pokemonId: Int) {
        self.pokemonId = pokemonId
        print("View \(String(pokemonId)) is built")
    }
}

#Preview {
    PokemonDetailView(pokemonId: 1)
}
