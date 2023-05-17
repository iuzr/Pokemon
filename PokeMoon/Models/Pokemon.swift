//
//  Pokemon.swift
//  PokeMoon
//
//  Created by Massimo Donini on 15/04/23.
//

import Foundation

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? JSONDecoder().decode(Welcome.self, from: jsonData)

// MARK: - Welcome
struct Welcome: Codable {
    let count: Int
    let next: String?
    var results: [Pokemon]
}

// MARK: - Result
struct Pokemon: Codable, Equatable {
    let name: String
    let url: String
    var image: String?
    
    enum codingKeys: String, CodingKey {
        case name, url
    }
}

extension Pokemon: Identifiable {
    var id: String {return name}
}

struct PokemonDetailData: Codable, Identifiable {
    // let abilities: [Ability]
    let baseExperience: Int?
    let height: Int
    let heldItems: [PokemonHeldItem]
    let id: Int
    let locationAreaEncounters: String
    let name: String
    let order: Int
    // let species: Species
    let sprites: Sprites
    let stats: [Stat]
    // let types: [TypeElement]
    let weight: Int
  
    enum CodingKeys: String, CodingKey {
        // case abilities
        case baseExperience = "base_experience"
        case height
        case heldItems = "held_items"
        case id
        case locationAreaEncounters = "location_area_encounters"
        case name, order
        case /*species,*/ sprites, stats, /*types,*/ weight
    }

    static let samplePokemon: PokemonDetailData = Bundle.main.decode(file: "PokemonSample.json")
}

struct PokemonHeldItem: Codable {
    let item: Item
}

extension PokemonHeldItem: Identifiable {
    var id: UUID {return UUID()}
}

struct Item: Codable {
    let name: String
    let url: String
}

struct ItemDetail: Codable, Identifiable {
    let id: Int
    let name: String
    let cost: Int
    let sprites: ItemSprites
}

struct ItemSprites: Codable {
    let `default`: String
}


// MARK: - Species
struct Species: Codable {
    let name: String
    let url: String
}

// MARK: - GenerationV
struct GenerationV: Codable {
    let blackWhite: Sprites

    enum CodingKeys: String, CodingKey {
        case blackWhite = "black-white"
    }
}

// MARK: - Versions
struct Versions: Codable {
    /*let generationI: GenerationI
    let generationIi: GenerationIi
    let generationIii: GenerationIii
    let generationIv: GenerationIv*/
    let generationV: GenerationV
    /*let generationVi: [String: Home]
    let generationVii: GenerationVii
    let generationViii: GenerationViii*/

    enum CodingKeys: String, CodingKey {
        /*case generationI = "generation-i"
        case generationIi = "generation-ii"
        case generationIii = "generation-iii"
        case generationIv = "generation-iv"*/
        case generationV = "generation-v"
        /*case generationVi = "generation-vi"
        case generationVii = "generation-vii"
        case generationViii = "generation-viii"*/
    }
}

// MARK: - Sprites
class Sprites: Codable {
    let backDefault: String?
//    let backFemale: String?
    let backShiny: String?
//    let backShinyFemale: String?
    let frontDefault: String?
//    let frontFemale: String?
    let frontShiny: String?
//    let frontShinyFemale: String?
    // let other: Other?
    let versions: Versions?
    let animated: Sprites?

    enum CodingKeys: String, CodingKey {
        case backDefault = "back_default"
//        case backFemale = "back_female"
        case backShiny = "back_shiny"
//        case backShinyFemale = "back_shiny_female"
        case frontDefault = "front_default"
//        case frontFemale = "front_female"
        case frontShiny = "front_shiny"
//        case frontShinyFemale = "front_shiny_female"
        case /*other,*/ versions, animated
    }
}

// MARK: - Stat
struct Stat: Codable {
    let baseStat, effort: Int
    let stat: Species

    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case effort, stat
    }
}

extension Stat: Identifiable {
    var id: UUID {return UUID()}
}

class JSONCodingKey: CodingKey {
    let key: String

    required init?(intValue: Int) {
        return nil
    }

    required init?(stringValue: String) {
        key = stringValue
    }

    var intValue: Int? {
        return nil
    }

    var stringValue: String {
        return key
    }
}

extension Bundle {
    func decode<T: Decodable>(file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Could not find \(file) in the project")
        }
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Could not load \(file)")
        }
        let decoder = JSONDecoder()
        guard let loadedData = try? decoder.decode(T.self, from: data) else {
            fatalError("Could not decode \(file)")
        }
        return loadedData
    }
}

