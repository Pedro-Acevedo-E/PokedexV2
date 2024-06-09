//
//  PokemonDetailViewModel.swift
//  PokedexV2
//
//  Created by Pedro Acevedo on 09/06/24.
//

import Foundation

extension PokemonDetailView {
    @Observable
    class PokemonDetailViewModel {
        var pokemonDetail: Pokemon?
        var pokemonSpecies: Pokemon?
    
        func loadDetails(id: Int) async {
            do {
                let response = try await URLSession.shared.data(from: URL(string: detailsBaseURL + String(id) + "/")!)
                let decodedPokemon = try JSONDecoder().decode(Pokemon.self, from: response.0)
                pokemonDetail = decodedPokemon
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }
        
        func loadSpeciesDetails(id: Int) async {
            do {
                let response = try await URLSession.shared.data(from: URL(string: speciesBaseURL + String(id) + "/")!)
                let decodedPokemon = try JSONDecoder().decode(Pokemon.self, from: response.0)
                pokemonSpecies = decodedPokemon
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}
