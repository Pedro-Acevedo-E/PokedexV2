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
        private var pokemonDetail: Pokemon?
        private var pokemonSpecies: Pokemon?
        private var evolutionChain: EvolutionChain?
        
        var loaded: Bool {
            if pokemonDetail != nil , pokemonSpecies != nil, evolutionChain != nil {
                return true
            }
            return false
        }
        
        var name: String {
            return pokemonDetail?.name ?? "Name Unavailable"
        }
        
        var id: String {
            return ("# " + String(pokemonDetail?.id ?? 0))
        }
        
        var flavorText: String {
            if let pokemon = pokemonSpecies, let flavorTextEntries = pokemon.flavorTextEntries {
                for entry in flavorTextEntries where entry.language.name == "en" {
                    return entry.flavorText.replacingOccurrences(of: "\n", with: " ")
                }
            }
            return ""
        }
        
        var genus: String {
            if let pokemon = pokemonSpecies, let genusEntries = pokemon.genera {
                for entry in genusEntries where entry.language.name == "en" {
                    return entry.genus
                }
            }
            return ""
        }
        
        var evolutionStage1: [Chain] {
            var forms: [Chain] = []
            if let chain = evolutionChain?.chain {
                forms.append(chain)
            }
            return forms
        }
        
        var evolutionStage2: [Chain] {
            var forms: [Chain] = []
            if let chain = evolutionChain?.chain.evolvesTo {
                for i in chain {
                    forms.append(i)
                }
            }
            return forms
        }
        
        var evolutionStage3: [Chain] {
            var forms: [Chain] = []
            if let chain = evolutionChain?.chain.evolvesTo {
                for i in chain {
                    for j in i.evolvesTo {
                        forms.append(j)
                    }
                }
            }
            return forms
        }
        
        var habitat: String {
            return pokemonSpecies?.habitat?.name ?? "Unknown"
        }
        
    
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
        
        func loadEvolutionChain() async {
            if let url = pokemonSpecies?.evolutionChain?.url {
                do {
                    let response = try await URLSession.shared.data(from: URL(string: url)!)
                    let decodedEvolutionChain = try JSONDecoder().decode(EvolutionChain.self, from: response.0)
                    evolutionChain = decodedEvolutionChain
                } catch {
                    print("Error: \(error.localizedDescription)")
                }
            }
        }
    }
}
