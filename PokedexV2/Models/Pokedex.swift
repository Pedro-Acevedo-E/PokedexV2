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
        getTypeColor(type: pokemonForms.first?.types.first?.pokemonType.name)
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
        getTypeColor(type: pokemonType.name)
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
