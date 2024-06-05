//
//  Utils.swift
//  PokedexV2
//
//  Created by Pedro Acevedo on 04/06/24.
//

import Foundation
import SwiftUI

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

func getTypeColor(type: String?) -> Color {
    switch type {
    case "grass":
        return Color(.grass)
    case "fire":
        return Color(.fire)
    case "water":
        return Color(.water)
    case "bug":
        return Color(.bug)
    case "electric":
        return Color(.electric)
    case "rock":
        return Color(.rock)
    case "ground":
        return Color(.ground)
    case "dark":
        return Color(.dark)
    case "fighting":
        return Color(.fighting)
    case "steel":
        return Color(.steel)
    case "normal":
        return Color(.normal)
    case "ghost":
        return Color(.ghost)
    case "poison":
        return Color(.poison)
    case "dragon":
        return Color(.dragon)
    case "flying":
        return Color(.flying)
    case "psychic":
        return Color(.psychic)
    case "fairy":
        return Color(.fairy)
    case "ice":
        return Color(.ice)
    default:
        return .white
    }
}
