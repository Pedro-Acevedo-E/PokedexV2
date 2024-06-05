//
//  PokedexEntry.swift
//  PokedexV2
//
//  Created by Pedro Acevedo on 31/05/24.
//

import Foundation
import SwiftUI

struct PokedexData: Codable {
    var data: Pokedex?
    var count: Int?
}

struct Pokedex: Codable {
    var pokedexEntries: [PokedexEntry]
}

struct PokedexEntry: Codable, Identifiable {
    var id: Int
    var name: String
    var pokemonForms: [PokemonForm]
    
    var color: Color {
        switch pokemonForms.first?.types.first?.pokemonType.name {
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
    
    var image: String { pokemonForms.first?.pokemonSprites.first?.sprites.officialArtwork?.frontDefault ?? ""}
}

struct PokemonForm: Codable, Identifiable {
    var id: Int
    var name: String
    var pokemonSpeciesId: Int
    var isDefault: Bool
    var types: [PokemonTypeData]
    var pokemonSprites: [PokemonSprite]
}

struct PokemonTypeData: Codable, Identifiable {
    var id: Int
    var pokemonType: PokemonType
    
    var color: Color {
        switch pokemonType.name {
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
}

struct PokemonType: Codable {
    var name: String
}

struct PokemonSprite: Codable, Identifiable {
    var id: Int
    var sprites: Sprite
}

struct Sprite: Codable {
    var officialArtwork: Artwork?
    
    enum CodingKeys: String, CodingKey {
        case officialArtwork = "official-artwork"
    }
}

struct Artwork: Codable {
    var frontDefault: String?
    var frontShiny: String?
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
        case frontShiny = "front_shiny"
    }
}
