//
//  Pokemon.swift
//  PDC Hatch WatchKit Extension
//
//  Created by Adrian Impedovo on 20/3/21.
//

import Foundation

class Pokemon : NSObject, NSCoding {
    var id: Int
    var name: String
    var exp: Int
    var dateHatched: String
    var dateRecieved: String
    var canGmax: Bool
    var isGmax: Bool
    var canEvolve: Bool
    var evolutionLevel: Int?
    var evolutionId: Int?
    var steps: Int
    
    static let StepsToHatchEgg = 10000;
    static let StepsToGmax = 500000;
    static let dateFormatString = "h:mm a 'on' MMM dd, yyyy"
    var formatter = DateFormatter();
    
    //make this function read from the PokemonData class static list
    //populate static list in PokemonData will all Pokemon data
    init (id: Int) {
        formatter.dateFormat = Pokemon.dateFormatString;
        formatter.amSymbol = "AM";
        formatter.pmSymbol = "PM";
        let pokemonData = PokemonData.pokemonDataList[id-1];
        
        self.id = pokemonData.id;
        self.name = pokemonData.name;
        self.exp = 0;
        self.dateHatched = "";
        self.dateRecieved = formatter.string(from: Date());
        self.canGmax = pokemonData.canGmax;
        self.isGmax = false;
        self.canEvolve = pokemonData.canEvolve;
        self.evolutionLevel = pokemonData.evolutionLevel;
        self.evolutionId = pokemonData.evolutionId;
        self.steps = 0;
    }
    
    init(id: Int, name: String, exp: Int, dateHatched: String, dateRecieved: String, canGmax: Bool, isGmax: Bool, canEvolve: Bool, evolutionLevel: Int?, evolutionId: Int?, steps: Int) {
        self.id = id;
        self.name = name;
        self.exp = exp;
        self.dateHatched = dateHatched;
        self.dateRecieved = dateRecieved;
        self.canGmax = canGmax;
        self.isGmax = isGmax;
        self.canEvolve = canEvolve;
        self.evolutionLevel = evolutionLevel;
        self.evolutionId = evolutionId;
        self.steps = steps;
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let id = aDecoder.decodeInteger(forKey: "id");
        let name = aDecoder.decodeObject(forKey: "name") as! String;
        let exp = aDecoder.decodeInteger(forKey: "exp");
        let dateHatched = aDecoder.decodeObject(forKey: "dateHatched") as! String;
        let dateRecieved = aDecoder.decodeObject(forKey: "dateRecieved") as! String;
        let canGmax = aDecoder.decodeBool(forKey: "canGmax");
        let isGmax = aDecoder.decodeBool(forKey: "isGmax");
        let canEvolve = aDecoder.decodeBool(forKey: "canEvolve");
        let evolutionLevel = aDecoder.decodeObject(forKey: "evolutionLevel") as! Int?;
        let evolutionId = aDecoder.decodeObject(forKey: "evolutionId") as! Int?;
        let steps = aDecoder.decodeInteger(forKey: "steps");
        
        self.init(id: id, name: name, exp: exp, dateHatched: dateHatched, dateRecieved: dateRecieved, canGmax: canGmax, isGmax: isGmax, canEvolve: canEvolve, evolutionLevel: evolutionLevel, evolutionId: evolutionId, steps: steps);
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(name, forKey: "name")
        aCoder.encode(exp, forKey: "exp")
        aCoder.encode(dateHatched, forKey: "dateHatched")
        aCoder.encode(dateRecieved, forKey: "dateRecieved")
        aCoder.encode(canGmax, forKey: "canGmax")
        aCoder.encode(isGmax, forKey: "isGmax")
        aCoder.encode(canEvolve, forKey: "canEvolve")
        aCoder.encode(evolutionLevel, forKey: "evolutionLevel")
        aCoder.encode(evolutionId, forKey: "evolutionId")
        aCoder.encode(steps, forKey: "steps")
    }
    
    private func getLevelDouble() -> Double {
        let levelDouble = exp ^^ Double(1.0/3.0);
        return levelDouble;
    }
    
    public func getLevelInt() -> Int {
        let levelInt = Int(floor(getLevelDouble()))
        return levelInt;
    }
    
    public func getNextLevelPercent() -> Double {
        let level = getLevelDouble();
        if (level >= 100) {
            return 1
        } else if (level < 1) {
            return Double(steps) / Double(Pokemon.StepsToHatchEgg);
        } else {
            return level - floor(level);
        }
    }
    
    public func getLevelString() -> String {
        let level = getLevelInt();
        if (level >= 100) {
            return "MAX";
        } else if (level == 0) {
            return steps >= Pokemon.StepsToHatchEgg ? "01" : "EGG";
        } else {
            if (level < 10) {
                return "0" + String(level);
            } else {
                return String(level);
            }
        }
    }
    
    public func getName() -> String {
        return isEgg() ? "Egg" : name;
    }
    
    public func getSpriteString() -> String {
        if (isGmax) {
            return String(id)+"g";
        } else {
            return isEgg() ? "0" : String(id);
        }
    }
    
    public func getIconString() -> String {
        return getSpriteString() + "i";
    }
    
    public func isEgg() -> Bool {
        return steps < Pokemon.StepsToHatchEgg;
    }
    
    public func walk(steps: Int) -> Void {
        let isPkmnEgg = isEgg();
        self.steps += steps;
        
        if (isPkmnEgg) {
            if (self.steps >= Pokemon.StepsToHatchEgg) {
                formatter.dateFormat = Pokemon.dateFormatString;
                formatter.amSymbol = "AM";
                formatter.pmSymbol = "PM";
                dateHatched = formatter.string(from: Date());
                let overstep = self.steps - Pokemon.StepsToHatchEgg;
                exp += overstep;
            }
        } else {
            exp += steps;
            
            if (canEvolve && evolutionLevel! <= getLevelInt()) {
                let evolution = Pokemon(id: evolutionId!);
                id = evolution.id;
                name = evolution.name;
                canGmax = evolution.canGmax;
                canEvolve = evolution.canEvolve;
                evolutionLevel = evolution.evolutionLevel;
                evolutionId = evolution.evolutionId;
            } else if (canGmax && !isGmax && self.steps > Pokemon.StepsToGmax) {
                isGmax = true;
            }
        }
    }
    
    public func getHatchText() -> String {
        if (steps < 5000) {
            return "It's not hatching anytime soon..."
        } else if (steps < 8000) {
            return "It will hatch eventually..."
        } else {
            return "It's gonna hatch soon!"
        }
    }
}

precedencegroup PowerPrecedence { higherThan: MultiplicationPrecedence }
infix operator ^^ : PowerPrecedence
func ^^ (radix: Int, power: Double) -> Double {
    return pow(Double(radix), Double(power))
}
