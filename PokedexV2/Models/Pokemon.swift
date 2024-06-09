//
//  Pokemon.swift
//  PokedexV2
//
//  Created by Pedro Acevedo on 09/06/24.
//

import Foundation

struct Pokemon: Codable, Identifiable {
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
        case evolutionChain = "evolution_chain"
        case flavorTextEntries = "flavor_text_entries"
        case genera
        case habitat
        case abilities
        case cries
        case height
        case sprites
        case stats
        case types
        case weight
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

struct EvolutionChain: Codable {
    var chain: Chain
    var id: Int
}

struct Chain: Codable, Identifiable {
    var id = UUID()
    var evolutionDetails: [EvolutionDetails]
    var evolvesTo: [Chain]
    var isBaby: Bool
    var species: NamedResource
    
    var imageURL: URL? {
        get {
            if let url = species.url {
                if let unwrappedLastPathComponent = URL(string: url)?.lastPathComponent {
                    return URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(unwrappedLastPathComponent).png")
                }
            }
            return nil
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case evolutionDetails = "evolution_details"
        case evolvesTo = "evolves_to"
        case isBaby = "is_baby"
        case species
    }
}

struct EvolutionDetails: Codable {
    var gender: Int?
    var heldItem: NamedResource?
    var item: NamedResource?
    var knownMove: NamedResource?
    var knownMoveType: NamedResource?
    var location: NamedResource?
    var minAffection: Int?
    var minBeauty: Int?
    var minHappiness: Int?
    var minLevel: Int?
    var needsOverworldRain: Bool
    var partySpecies: NamedResource?
    var partyType: NamedResource?
    var relativePhysicalStats: Int?
    var timeOfDay: String
    var tradeSpecies: NamedResource?
    var trigger: NamedResource?
    var turnUpsideDown: Bool
    
    enum CodingKeys: String, CodingKey {
        case gender
        case heldItem = "evolves_to"
        case item
        case knownMove = "known_move"
        case knownMoveType = "known_move_type"
        case location
        case minAffection = "min_affection"
        case minBeauty = "min_beauty"
        case minHappiness = "min_happiness"
        case minLevel = "min_level"
        case needsOverworldRain = "needs_overworld_rain"
        case partySpecies = "party_species"
        case partyType = "party_type"
        case relativePhysicalStats = "relative_physical_stats"
        case timeOfDay = "time_of_day"
        case tradeSpecies = "trade_species"
        case trigger
        case turnUpsideDown = "turn_upside_down"
    }
}

