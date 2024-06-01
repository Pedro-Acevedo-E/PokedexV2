//
//  ContentView.swift
//  PokedexV2
//
//  Created by Pedro Acevedo on 30/05/24.
//

import SwiftUI

struct ContentView: View {
    @State var entries: [PokedexEntry] = []
    var columns: [GridItem] = [
        GridItem(.adaptive(minimum: 180))
    ]
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [.blue, .white]),
                startPoint: .top,
                endPoint: .bottom
            )
            VStack {
                ScrollView {
                    Rectangle()
                        .foregroundColor(.black.opacity(0))
                        .frame(maxWidth: .infinity, minHeight: 60)
                    LazyVGrid(columns: columns) {
                        ForEach(entries) { i in
                            ZStack {
                                Rectangle()
                                    .fill(
                                        LinearGradient(
                                            gradient: Gradient(colors: [i.color, i.color.opacity(0.4)]),
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        )
                                    )
                                    .frame(width: 180, height: 180)
                                VStack {
                                    AsyncImage(url: URL(string: i.image)) { phase in
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
                                    Text(i.name)
                                    HStack {
                                        ForEach(i.pokemonForms.first?.types ?? []) { type in
                                            ZStack {
                                                RoundedRectangle(cornerRadius: 25)
                                                    .fill(type.color)
                                                    .stroke(.white, lineWidth: 1)
                                                    .frame(width: 80, height: 30)
                                                Text(type.pokemonType.name)
                                            }
                                        }
                                    }
                                }
                            }
                            .clipShape(RoundedRectangle(cornerRadius: 25))
                        }
                    }
                    Rectangle()
                        .foregroundColor(.black.opacity(0))
                        .frame(maxWidth: .infinity, minHeight: 40)
                }
            }
            VStack(spacing: 0) {
                Rectangle()
                    .foregroundColor(.red)
                    .frame(maxWidth: .infinity, maxHeight: 50)
                Rectangle()
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, maxHeight: 8)
                Spacer()
                Rectangle()
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, maxHeight: 8)
                Rectangle()
                    .foregroundColor(.red)
                    .frame(maxWidth: .infinity, maxHeight: 30)
            }
        }
        .task {
            await loadData()
        }
        .ignoresSafeArea()
    }
    
    func loadData() async {
        let url = URL(string: "https://beta.pokeapi.co/graphql/v1beta")!
        let query = """
            query PokeAPIquery {
              pokedexEntries: pokemon_v2_pokemonspecies(limit: 50, offset: 0, distinct_on: id) {
                id
                name
                pokemonForms: pokemon_v2_pokemons {
                  id
                  name
                  pokemonSpeciesId: pokemon_species_id
                  isDefault: is_default
                  types: pokemon_v2_pokemontypes {
                    id
                    pokemonType: pokemon_v2_type {
                      name
                    }
                  }
                  pokemonSprites: pokemon_v2_pokemonsprites {
                    id
                    sprites(path: "other")
                  }
                }
              }
            }
        """
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: ["query": query, "variables": nil], options: [])
        
        do {
            let response = try await URLSession.shared.data(for: request)
            let decodedPokedex = try JSONDecoder().decode(PokedexData.self, from: response.0)
            entries = decodedPokedex.data.pokedexEntries
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
}

#Preview {
    ContentView()
}
