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
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [getTypeColor(type: pokemon.types.first), getTypeColor(type: pokemon.types.first).opacity(0.4)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            VStack {
                ScrollView {
                    Rectangle()
                        .foregroundColor(.black.opacity(0))
                        .containerRelativeFrame(.vertical, count: 6, span: 1, spacing: 0)
                    if pokemon.loaded {
                        AsyncImage(url: URL(string: pokemon.image)) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                                    .frame(width: 90, height: 90)
                            case .success(let image):
                                image.resizable().scaledToFit()
                                    .containerRelativeFrame(.horizontal, count: 2, span: 1, spacing: 0)
                            case .failure:
                                Image(systemName: "questionmark")
                            @unknown default:
                                Image(systemName: "questionmark")
                            }
                        }
                        HStack {
                            ForEach(pokemon.types, id: \.self) { type in
                                ZStack {
                                    RoundedRectangle(cornerRadius: 25)
                                        .fill(getTypeColor(type: type).opacity(0.8))
                                        .stroke(.white, lineWidth: 1)
                                        .frame(width: 80, height: 30)
                                    Text(type)
                                }
                            }
                        }
                        Divider()
                        VStack() {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text("Species")
                                        .font(.headline)
                                    Text(pokemon.genus)
                                        .font(.title)
                                }
                                Spacer()
                                VStack(alignment: .leading) {
                                    Text("Habitat")
                                        .font(.headline)
                                    Text(pokemon.habitat)
                                        .font(.title)
                                }
                            }
                            .padding(.horizontal)
                            
                            HStack {
                                VStack(alignment: .leading) {
                                    Text("Description")
                                        .font(.headline)
                                    Text(pokemon.flavorText)
                                        .font(.title)
                                }
                                Spacer()
                            }
                            .padding()
                            
                            HStack {
                                VStack(alignment: .leading) {
                                    Text("Height")
                                        .font(.headline)
                                    Text(pokemon.height)
                                        .font(.title)
                                }
                                Spacer()
                                VStack(alignment: .leading) {
                                    Text("Weight")
                                        .font(.headline)
                                    Text(pokemon.weight)
                                        .font(.title)
                                }
                            }
                            .padding(.horizontal)
                            
                            HStack {
                                VStack(alignment: .leading) {
                                    Text("Abilities")
                                        .font(.headline)
                                    HStack {
                                        ForEach(pokemon.abilities, id: \.self) { ability in
                                            Text(ability)
                                                .font(.title)
                                            Spacer()
                                        }
                                    }
                                }
                                Spacer()
                            }
                            .padding()
                        }
                        .padding()
                        
                        Divider()
                        
                        Text("Evolution chain ")
                            .font(.headline)
                            .padding()
                        
                        EvolutionChainView(chain: pokemon.evolutionStage1)
                        EvolutionChainView(chain: pokemon.evolutionStage2)
                        EvolutionChainView(chain: pokemon.evolutionStage3)
                        
                        Divider()
                        
                        Text("Base Stats")
                            .font(.headline)
                            .padding()
                        
                        ForEach(pokemon.stats) { stat in
                            VStack {
                                Text((stat.stat.name ?? "") + ": " + String(stat.baseStat))
                                    .font(.headline)
                                ColoredProgressBar(value: stat.baseStat)
                                    .padding(.bottom)
                            }
                            .padding(.horizontal)
                        }
                        
                        Rectangle()
                            .foregroundColor(.black.opacity(0))
                            .containerRelativeFrame(.vertical, count: 15, span: 1, spacing: 0)
                        
                    } else {
                        ProgressView()
                    }
                }
            }
            .navigationTitle("\(pokemon.name) \(pokemon.id)")
            .navigationBarTitleDisplayMode(.large)
            .toolbarBackground(getTypeColor(type: pokemon.types.first ?? ""), for: .navigationBar, .tabBar)
        }
        .ignoresSafeArea()
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
