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
    let next: String
    var results: [Pokemon]
}

// MARK: - Result
struct Pokemon: Codable {
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

// MARK: - Welcome
struct PokemonDetailData: Codable, Identifiable {
    let abilities: [Ability]
    let baseExperience: Int
    let height: Int
    let heldItems: [PokemonHeldItem]
    let id: Int
    let locationAreaEncounters: String
    let name: String
    let order: Int
    let species: Species
    let sprites: Sprites
    let stats: [Stat]
    let types: [TypeElement]
    let weight: Int
  
    enum CodingKeys: String, CodingKey {
        case abilities
        case baseExperience = "base_experience"
        case height
        case heldItems = "held_items"
        case id
        case locationAreaEncounters = "location_area_encounters"
        case name, order
        case species, sprites, stats, types, weight
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

// MARK: - Ability
struct Ability: Codable {
    let ability: Species
    let isHidden: Bool
    let slot: Int

    enum CodingKeys: String, CodingKey {
        case ability
        case isHidden = "is_hidden"
        case slot
    }
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

// MARK: - GenerationIv
struct GenerationIv: Codable {
    let diamondPearl, heartgoldSoulsilver, platinum: Sprites

    enum CodingKeys: String, CodingKey {
        case diamondPearl = "diamond-pearl"
        case heartgoldSoulsilver = "heartgold-soulsilver"
        case platinum
    }
}

// MARK: - Versions
struct Versions: Codable {
    let generationI: GenerationI
    let generationIi: GenerationIi
    let generationIii: GenerationIii
    let generationIv: GenerationIv
    let generationV: GenerationV
    let generationVi: [String: Home]
    let generationVii: GenerationVii
    let generationViii: GenerationViii

    enum CodingKeys: String, CodingKey {
        case generationI = "generation-i"
        case generationIi = "generation-ii"
        case generationIii = "generation-iii"
        case generationIv = "generation-iv"
        case generationV = "generation-v"
        case generationVi = "generation-vi"
        case generationVii = "generation-vii"
        case generationViii = "generation-viii"
    }
}

// MARK: - Sprites
class Sprites: Codable {
    let backDefault: String
    let backFemale: String?
    let backShiny: String
    let backShinyFemale: String?
    let frontDefault: String
    let frontFemale: String?
    let frontShiny: String
    let frontShinyFemale: String?
    let other: Other?
    let versions: Versions?
    let animated: Sprites?

    enum CodingKeys: String, CodingKey {
        case backDefault = "back_default"
        case backFemale = "back_female"
        case backShiny = "back_shiny"
        case backShinyFemale = "back_shiny_female"
        case frontDefault = "front_default"
        case frontFemale = "front_female"
        case frontShiny = "front_shiny"
        case frontShinyFemale = "front_shiny_female"
        case other, versions, animated
    }

    /*init(backDefault: String, backFemale: JSONNull?, backShiny: String, backShinyFemale: JSONNull?, frontDefault: String, frontFemale: JSONNull?, frontShiny: String, frontShinyFemale: JSONNull?, other: Other?, versions: Versions?, animated: Sprites?) {
        self.backDefault = backDefault
        self.backFemale = backFemale
        self.backShiny = backShiny
        self.backShinyFemale = backShinyFemale
        self.frontDefault = frontDefault
        self.frontFemale = frontFemale
        self.frontShiny = frontShiny
        self.frontShinyFemale = frontShinyFemale
        self.other = other
        self.versions = versions
        self.animated = animated
    }*/
}

// MARK: - GenerationI
struct GenerationI: Codable {
    let redBlue, yellow: RedBlue

    enum CodingKeys: String, CodingKey {
        case redBlue = "red-blue"
        case yellow
    }
}

// MARK: - RedBlue
struct RedBlue: Codable {
    let backDefault, backGray, backTransparent, frontDefault: String
    let frontGray, frontTransparent: String

    enum CodingKeys: String, CodingKey {
        case backDefault = "back_default"
        case backGray = "back_gray"
        case backTransparent = "back_transparent"
        case frontDefault = "front_default"
        case frontGray = "front_gray"
        case frontTransparent = "front_transparent"
    }
}

// MARK: - GenerationIi
struct GenerationIi: Codable {
    let crystal: Crystal
    let gold, silver: Gold
}

// MARK: - Crystal
struct Crystal: Codable {
    let backDefault, backShiny, backShinyTransparent, backTransparent: String
    let frontDefault, frontShiny, frontShinyTransparent, frontTransparent: String

    enum CodingKeys: String, CodingKey {
        case backDefault = "back_default"
        case backShiny = "back_shiny"
        case backShinyTransparent = "back_shiny_transparent"
        case backTransparent = "back_transparent"
        case frontDefault = "front_default"
        case frontShiny = "front_shiny"
        case frontShinyTransparent = "front_shiny_transparent"
        case frontTransparent = "front_transparent"
    }
}

// MARK: - Gold
struct Gold: Codable {
    let backDefault, backShiny, frontDefault, frontShiny: String
    let frontTransparent: String?

    enum CodingKeys: String, CodingKey {
        case backDefault = "back_default"
        case backShiny = "back_shiny"
        case frontDefault = "front_default"
        case frontShiny = "front_shiny"
        case frontTransparent = "front_transparent"
    }
}

// MARK: - GenerationIii
struct GenerationIii: Codable {
    let emerald: OfficialArtwork
    let fireredLeafgreen, rubySapphire: Gold

    enum CodingKeys: String, CodingKey {
        case emerald
        case fireredLeafgreen = "firered-leafgreen"
        case rubySapphire = "ruby-sapphire"
    }
}

// MARK: - OfficialArtwork
struct OfficialArtwork: Codable {
    let frontDefault, frontShiny: String

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
        case frontShiny = "front_shiny"
    }
}

// MARK: - Home
struct Home: Codable {
    let frontDefault: String
    let frontFemale: String?
    let frontShiny: String
    let frontShinyFemale: String?

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
        case frontFemale = "front_female"
        case frontShiny = "front_shiny"
        case frontShinyFemale = "front_shiny_female"
    }
}

// MARK: - GenerationVii
struct GenerationVii: Codable {
    let icons: DreamWorld
    let ultraSunUltraMoon: Home?

    enum CodingKeys: String, CodingKey {
        case icons
        case ultraSunUltraMoon = "ultra-sun-ultra-moon"
    }
}

// MARK: - DreamWorld
struct DreamWorld: Codable {
    let frontDefault: String
    let frontFemale: String?

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
        case frontFemale = "front_female"
    }
}

// MARK: - GenerationViii
struct GenerationViii: Codable {
    let icons: DreamWorld
}

// MARK: - Other
struct Other: Codable {
    let dreamWorld: DreamWorld
    let home: Home?
    let officialArtwork: OfficialArtwork

    enum CodingKeys: String, CodingKey {
        case dreamWorld = "dream_world"
        case home
        case officialArtwork = "official-artwork"
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

// MARK: - TypeElement
struct TypeElement: Codable {
    let slot: Int
    let type: Species
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

