//
//  Utils.swift
//  PokedexV2
//
//  Created by Pedro Acevedo on 04/06/24.
//

import Foundation

func buildQuery(offset: Int) -> String {
    let stringOffset = String(offset * 50)
    return """
        query PokeAPIquery {
          pokedexEntries: pokemon_v2_pokemonspecies(limit: 50, offset: \(stringOffset), distinct_on: id) {
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
}
