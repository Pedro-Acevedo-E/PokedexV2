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
            ScrollView {
                if pokemon.loaded {
                    Text("General pokemon information: ")
                        .bold()
                        .padding(.bottom)
                    Text("Pokemon ID: " + pokemon.id)
                    Text("Pokemon Name: " + pokemon.name)
                    Text("Flavor text: " + pokemon.flavorText)
                    Text("Species: " + pokemon.genus)
                    Text("Habitat: " + pokemon.habitat)
                    Text("Stage 1 evolution: ")
                    ForEach(pokemon.evolutionStage1) { pkm in
                        Text(pkm.species.name ?? "")
                    }
                    Text("Stage 2 evolution: ")
                    ForEach(pokemon.evolutionStage2) { pkm in
                        Text(pkm.species.name ?? "")
                    }
                    Text("Stage 3 evolution: ")
                    ForEach(pokemon.evolutionStage3) { pkm in
                        Text(pkm.species.name ?? "")
                    }
                    Text("Abilities: ")
                    HStack {
                        ForEach(pokemon.abilities, id: \.self) { ability in
                            Text(ability)
                        }
                    }
                    Text("Height: \(pokemon.height)")
                    AsyncImage(url: URL(string: pokemon.image)) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .frame(width: 90, height: 90)
                        case .success(let image):
                            image.resizable()
                                .frame(width: 90, height: 90)
                        case .failure:
                            Image(systemName: "questionmark")
                        @unknown default:
                            Image(systemName: "questionmark")
                        }
                    }
                    Text("Stats: ")
                    ForEach(pokemon.stats) { stat in
                        HStack {
                            Text(stat.stat.name ?? "")
                            Text(": " + String(stat.baseStat))
                        }
                    }
                    Text("Types: ")
                    ForEach(pokemon.types, id: \.self) { type in
                        Text(type)
                    }
                    Text("Weight: \(pokemon.weight)")
                    
                } else {
                    ProgressView()
                }
            }
        }
        .task {
            await pokemon.loadDetails(id: pokemonId)
            await pokemon.loadSpeciesDetails(id: pokemonId)
            await pokemon.loadEvolutionChain()
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
