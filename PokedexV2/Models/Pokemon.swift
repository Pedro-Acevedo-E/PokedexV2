//
//  Pokemon.swift
//  PokedexV2
//
//  Created by Pedro Acevedo on 09/06/24.
//

import Foundation

struct Pokemon: Codable {
    var id: Int
    var name: String
    var evolutionChain: NamedResource?
    var flavorTextEntries: [FlavorTextEntry]?
    var genera: [PokemonGenus]?
    var habitat: NamedResource?
    
    var abilities: [PokemonAbility]?
    var cries: PokemonSound?
    var height: Int?
    var sprites: PokemonSprites?
    var stats: [PokemonStat]?
    var types: [PokemonTypes]?
    var weight: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case evolutionChain = "evolution-chain"
        case flavorTextEntries = "flavor_text_entries"
    }
}

struct NamedResource: Codable {
    var name: String?
    var url: String?
}

struct FlavorTextEntry: Codable {
    var flavorText: String
    var language: NamedResource
    
    enum CodingKeys: String, CodingKey {
        case flavorText = "flavor_text"
        case language
    }
}

struct PokemonGenus: Codable {
    var genus: String
    var language: NamedResource
}

struct PokemonAbility: Codable {
    var ability: NamedResource
    var isHidden: Bool
    var slot: Int
    
    enum CodingKeys: String, CodingKey {
        case ability
        case isHidden = "is_hidden"
        case slot
    }
}

struct PokemonSound: Codable {
    var latest: String?
    var legacy: String?
}

struct PokemonSprites: Codable {
    var other: OtherSprites
}

struct PokemonImages: Codable {
    var frontDefault: String?
    var frontShiny: String?
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
        case frontShiny = "front_shiny"
    }
}

struct OtherSprites: Codable {
    var dreamWorld: PokemonImages?
    var home: PokemonImages?
    var officialArtwork: PokemonImages?
    
    enum CodingKeys: String, CodingKey {
        case dreamWorld = "dream_world"
        case home
        case officialArtwork = "official-artwork"
    }
}

struct PokemonStat: Codable {
    var baseStat: Int
    var effort: Int
    var stat: NamedResource
    
    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case effort
        case stat
    }
}

struct PokemonTypes: Codable {
    var slot: Int
    var type: NamedResource
}

