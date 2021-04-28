//
//  PokemonData.swift
//  PDC Hatch WatchKit Extension
//
//  Created by Adrian Impedovo on 21/3/21.
//

import Foundation
class PokemonData {
    var id: Int
    var name: String
    var canGmax: Bool
    var canEvolve: Bool
    var evolutionLevel: Int?
    var evolutionId: Int?
    
    static var pokemonDataList =
        [PokemonData(id: 1, name: "Bulbasaur", canGmax: false, canEvolve: true, evolutionLevel: 25, evolutionId: 2),
         PokemonData(id: 2, name: "Ivysaur", canGmax: false, canEvolve: true, evolutionLevel: 50, evolutionId: 3),
         PokemonData(id: 3, name: "Venusaur", canGmax: true, canEvolve: false, evolutionLevel: nil, evolutionId: nil),
        PokemonData(id: 4, name: "Charmander", canGmax: false, canEvolve: true, evolutionLevel: 25, evolutionId: 5),
        PokemonData(id: 5, name: "Charmeleon", canGmax: false, canEvolve: true, evolutionLevel: 50, evolutionId: 6),
        PokemonData(id: 6, name: "Charizard", canGmax: true, canEvolve: false, evolutionLevel: nil, evolutionId: nil),
        PokemonData(id: 7, name: "Squirtle", canGmax: false, canEvolve: true, evolutionLevel: 25, evolutionId: 8),
        PokemonData(id: 8, name: "Wartortle", canGmax: false, canEvolve: true, evolutionLevel: 50, evolutionId: 9),
        PokemonData(id: 9, name: "Blastoise", canGmax: true, canEvolve: false, evolutionLevel: nil, evolutionId: nil),
        PokemonData(id: 10, name: "Caterpie", canGmax: false, canEvolve: true, evolutionLevel: 10, evolutionId: 11),
        PokemonData(id: 11, name: "Metapod", canGmax: false, canEvolve: true, evolutionLevel: 20, evolutionId: 12),
        PokemonData(id: 12, name: "Butterfree", canGmax: true, canEvolve: false, evolutionLevel: nil, evolutionId: nil),
        PokemonData(id: 13, name: "Pichu", canGmax: false, canEvolve: true, evolutionLevel: 30, evolutionId: 14),
        PokemonData(id: 14, name: "Pikachu", canGmax: true, canEvolve: false, evolutionLevel: nil, evolutionId: nil),
        PokemonData(id: 15, name: "Meowth", canGmax: true, canEvolve: false, evolutionLevel: nil, evolutionId: nil),
        PokemonData(id: 16, name: "Machop", canGmax: false, canEvolve: true, evolutionLevel: 30, evolutionId: 17),
        PokemonData(id: 17, name: "Machoke", canGmax: false, canEvolve: true, evolutionLevel: 55, evolutionId: 18),
        PokemonData(id: 18, name: "Machamp", canGmax: true, canEvolve: false, evolutionLevel: nil, evolutionId: nil),
        PokemonData(id: 19, name: "Gastly", canGmax: false, canEvolve: true, evolutionLevel: 30, evolutionId: 20),
        PokemonData(id: 20, name: "Haunter", canGmax: false, canEvolve: true, evolutionLevel: 55, evolutionId: 21),
        PokemonData(id: 21, name: "Gengar", canGmax: true, canEvolve: false, evolutionLevel: nil, evolutionId: nil),
        PokemonData(id: 22, name: "Krabby", canGmax: false, canEvolve: true, evolutionLevel: 40, evolutionId: 23),
        PokemonData(id: 23, name: "Kingler", canGmax: true, canEvolve: false, evolutionLevel: nil, evolutionId: nil),
        PokemonData(id: 24, name: "Happiny", canGmax: false, canEvolve: true, evolutionLevel: 40, evolutionId: 25),
        PokemonData(id: 25, name: "Chansey", canGmax: false, canEvolve: true, evolutionLevel: 80, evolutionId: 26),
        PokemonData(id: 26, name: "Blissey", canGmax: false, canEvolve: false, evolutionLevel: nil, evolutionId: nil),
        PokemonData(id: 27, name: "Lapras", canGmax: true, canEvolve: false, evolutionLevel: nil, evolutionId: nil),
        PokemonData(id: 28, name: "Eevee", canGmax: true, canEvolve: false, evolutionLevel: nil, evolutionId: nil),
        PokemonData(id: 29, name: "Munchlax", canGmax: false, canEvolve: true, evolutionLevel: 30, evolutionId: 30),
        PokemonData(id: 30, name: "Snorlax", canGmax: true, canEvolve: false, evolutionLevel: nil, evolutionId: nil),
        PokemonData(id: 31, name: "Trubbish", canGmax: false, canEvolve: true, evolutionLevel: 50, evolutionId: 32),
        PokemonData(id: 32, name: "Garbodor", canGmax: true, canEvolve: false, evolutionLevel: nil, evolutionId: nil),
        PokemonData(id: 33, name: "Meltan", canGmax: false, canEvolve: true, evolutionLevel: 60, evolutionId: 34),
        PokemonData(id: 34, name: "Melmetal", canGmax: true, canEvolve: false, evolutionLevel: nil, evolutionId: nil),
        PokemonData(id: 35, name: "Grookey", canGmax: false, canEvolve: true, evolutionLevel: 25, evolutionId: 36),
        PokemonData(id: 36, name: "Thwackey", canGmax: false, canEvolve: true, evolutionLevel: 50, evolutionId: 37),
        PokemonData(id: 37, name: "Rillaboom", canGmax: true, canEvolve: false, evolutionLevel: nil, evolutionId: nil),
        PokemonData(id: 38, name: "Scorbunny", canGmax: false, canEvolve: true, evolutionLevel: 25, evolutionId: 39),
        PokemonData(id: 39, name: "Raboot", canGmax: false, canEvolve: true, evolutionLevel: 50, evolutionId: 40),
        PokemonData(id: 40, name: "Cinderace", canGmax: true, canEvolve: false, evolutionLevel: nil, evolutionId: nil),
        PokemonData(id: 41, name: "Sobble", canGmax: false, canEvolve: true, evolutionLevel: 25, evolutionId: 42),
        PokemonData(id: 42, name: "Drizzile", canGmax: false, canEvolve: true, evolutionLevel: 50, evolutionId: 43),
        PokemonData(id: 43, name: "Inteleon", canGmax: true, canEvolve: false, evolutionLevel: nil, evolutionId: nil),
        PokemonData(id: 44, name: "Rookidee", canGmax: false, canEvolve: true, evolutionLevel: 27, evolutionId: 45),
        PokemonData(id: 45, name: "Corvisquire", canGmax: false, canEvolve: true, evolutionLevel: 55, evolutionId: 46),
        PokemonData(id: 46, name: "Corviknight", canGmax: true, canEvolve: false, evolutionLevel: nil, evolutionId: nil),
        PokemonData(id: 47, name: "Blipbug", canGmax: false, canEvolve: true, evolutionLevel: 20, evolutionId: 48),
        PokemonData(id: 48, name: "Dottler", canGmax: false, canEvolve: true, evolutionLevel: 45, evolutionId: 49),
        PokemonData(id: 49, name: "Orbettle", canGmax: true, canEvolve: false, evolutionLevel: nil, evolutionId: nil),
        PokemonData(id: 50, name: "Chewtle", canGmax: false, canEvolve: true, evolutionLevel: 40, evolutionId: 51),
        PokemonData(id: 51, name: "Drednaw", canGmax: true, canEvolve: false, evolutionLevel: nil, evolutionId: nil),
        PokemonData(id: 52, name: "Rolycoly", canGmax: false, canEvolve: true, evolutionLevel: 30, evolutionId: 53),
        PokemonData(id: 53, name: "Carkol", canGmax: false, canEvolve: true, evolutionLevel: 55, evolutionId: 54),
        PokemonData(id: 54, name: "Coalossal", canGmax: true, canEvolve: false, evolutionLevel: nil, evolutionId: nil),
        PokemonData(id: 55, name: "Applin", canGmax: false, canEvolve: true, evolutionLevel: 40, evolutionId: 56),
        PokemonData(id: 56, name: "Appletun", canGmax: true, canEvolve: false, evolutionLevel: nil, evolutionId: nil),
        PokemonData(id: 57, name: "Silicobra", canGmax: false, canEvolve: true, evolutionLevel: 50, evolutionId: 58),
        PokemonData(id: 58, name: "Sandaconda", canGmax: true, canEvolve: false, evolutionLevel: nil, evolutionId: nil),
        PokemonData(id: 59, name: "Toxel", canGmax: false, canEvolve: true, evolutionLevel: 45, evolutionId: 60),
        PokemonData(id: 60, name: "Toxtricity", canGmax: true, canEvolve: false, evolutionLevel: nil, evolutionId: nil),
        PokemonData(id: 61, name: "Sizzlipede", canGmax: false, canEvolve: true, evolutionLevel: 40, evolutionId: 62),
        PokemonData(id: 62, name: "Centiskorch", canGmax: true, canEvolve: false, evolutionLevel: nil, evolutionId: nil),
        PokemonData(id: 63, name: "Hatenna", canGmax: false, canEvolve: true, evolutionLevel: 40, evolutionId: 64),
        PokemonData(id: 64, name: "Hattrem", canGmax: false, canEvolve: true, evolutionLevel: 60, evolutionId: 65),
        PokemonData(id: 65, name: "Hatterene", canGmax: true, canEvolve: false, evolutionLevel: nil, evolutionId: nil),
        PokemonData(id: 66, name: "Impidimp", canGmax: false, canEvolve: true, evolutionLevel: 40, evolutionId: 67),
        PokemonData(id: 67, name: "Morgrem", canGmax: false, canEvolve: true, evolutionLevel: 60, evolutionId: 68),
        PokemonData(id: 68, name: "Grimmsnarl", canGmax: true, canEvolve: false, evolutionLevel: nil, evolutionId: nil),
        PokemonData(id: 69, name: "Milcery", canGmax: false, canEvolve: true, evolutionLevel: 35, evolutionId: 70),
        PokemonData(id: 70, name: "Alcremie", canGmax: true, canEvolve: false, evolutionLevel: nil, evolutionId: nil),
        PokemonData(id: 71, name: "Cufant", canGmax: false, canEvolve: true, evolutionLevel: 50, evolutionId: 72),
        PokemonData(id: 72, name: "Copperajah", canGmax: true, canEvolve: false, evolutionLevel: nil, evolutionId: nil),
        PokemonData(id: 73, name: "Duraludon", canGmax: true, canEvolve: false, evolutionLevel: nil, evolutionId: nil)];
    
    init(id: Int, name: String, canGmax: Bool = false, canEvolve: Bool = false, evolutionLevel: Int? = nil, evolutionId: Int? = nil) {
        self.id = id;
        self.name = name;
        self.canGmax = canGmax;
        self.canEvolve = canEvolve;
        self.evolutionLevel = evolutionLevel;
        self.evolutionId = evolutionId;
    }
}
