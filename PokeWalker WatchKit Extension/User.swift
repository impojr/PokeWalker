//
//  User.swift
//  PDC Hatch WatchKit Extension
//
//  Created by Adrian Impedovo on 22/3/21.
//

import Foundation

class User : NSObject, NSCoding {
    var name: String;
    var availableEggs: [Int]
    var pokemon: [Pokemon]
    var noMoreEggs: Bool
    var receivedHappiny: Bool
    var allGmaxed: Bool
    var twentyEggsReceived: Bool
    var hundredThousandStepsWalked: Bool
    var millionStepsWalked: Bool
    var lastGoalReachedDate: Date
    var lastSyncDate: Date
    var notificationsEnabled: Bool
    
    override init() {
        //self.name = "Adrian";
        //self.name = "Rynier";
        //self.name = "Elisa";
        //self.pokemon = [ Pokemon(id: 13) ] //Adrian
        //self.pokemon = [ Pokemon(id: 29) ] //Rynier
        //self.pokemon = [ Pokemon(id: 69) ] //Elisa
        //self.availableEggs = [1,4,7,10,15,16,19,22,27,28,29,31,33,35,38,41,44,47,50,52,55,57,59,61,63,66,69,71,73]; //Adrian
        //self.availableEggs = [1,4,7,10,13,15,16,19,22,27,28,31,33,35,38,41,44,47,50,52,55,57,59,61,63,66,69,71,73]; //Rynier
        //self.availableEggs = [1,4,7,10,13,15,16,19,22,27,28,29,31,33,35,38,41,44,47,50,52,55,57,59,61,63,66,71,73]; //Elisa
        self.name = "";
        self.pokemon = [];
        self.availableEggs = [1,4,7,10,13,15,16,19,22,27,28,29,31,33,35,38,41,44,47,50,52,55,57,59,61,63,66,69,71,73];
        self.noMoreEggs = false;
        self.receivedHappiny = false;
        self.allGmaxed = false;
        self.twentyEggsReceived = false;
        self.hundredThousandStepsWalked = false;
        self.millionStepsWalked = false;
        self.lastGoalReachedDate = Date(timeIntervalSince1970: 0);
        self.lastSyncDate = Date(timeIntervalSince1970: 0);
        self.notificationsEnabled = false;
    }
    
    init(name: String, availableEggs: [Int], pokemon: [Pokemon], noMoreEggs: Bool, receivedHappiny: Bool, lastGoalReachedDate: Date, lastSyncDate: Date, allGmaxed: Bool, twentyEggsReceived: Bool, hundredThousandStepsWalked: Bool, millionStepsWalked: Bool, notificationsEnabled: Bool) {
        self.name = name;
        self.availableEggs = availableEggs;
        self.pokemon = pokemon;
        self.noMoreEggs = noMoreEggs;
        self.receivedHappiny = receivedHappiny;
        self.lastGoalReachedDate = lastGoalReachedDate;
        self.lastSyncDate = lastSyncDate;
        self.hundredThousandStepsWalked = hundredThousandStepsWalked;
        self.millionStepsWalked = millionStepsWalked;
        self.twentyEggsReceived = twentyEggsReceived;
        self.allGmaxed = allGmaxed;
        self.notificationsEnabled = notificationsEnabled;
    }
    
    static var Player: User = User();
    
    public static func Save() {
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: User.Player)
        UserDefaults.standard.set(encodedData, forKey: "player")
        UserDefaults.standard.synchronize()
    }
    
    public static func Load() {
        let userDefaults = UserDefaults.standard
        let decoded  = userDefaults.object(forKey: "player") as! Data
        let decodedUser = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! User
        User.Player = decodedUser;
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObject(forKey: "name") as! String;
        let availableEggs = aDecoder.decodeObject(forKey: "availableEggs") as! [Int];
        let pokemon = aDecoder.decodeObject(forKey: "pokemon") as! [Pokemon];
        let noMoreEggs = aDecoder.decodeBool(forKey: "noMoreEggs");
        let receivedHappiny = aDecoder.decodeBool(forKey: "receivedHappiny");
        let lastGoalReachedDate = aDecoder.decodeObject(forKey: "lastGoalReachedDate") as! Date;
        
        let lastSyncDate = aDecoder.decodeObject(forKey: "lastSyncDate") as! Date;
        
        let hundredThousandStepsWalked = aDecoder.decodeBool(forKey: "hundredThousandStepsWalked");
        let millionStepsWalked = aDecoder.decodeBool(forKey: "millionStepsWalked");
        let allGmaxed = aDecoder.decodeBool(forKey: "allGmaxed");
        let twentyEggsReceived = aDecoder.decodeBool(forKey: "twentyEggsReceived");
        let notificationsEnabled = aDecoder.decodeBool(forKey: "notificationsEnabled");
        
        self.init(name: name, availableEggs: availableEggs, pokemon: pokemon, noMoreEggs: noMoreEggs, receivedHappiny: receivedHappiny, lastGoalReachedDate: lastGoalReachedDate, lastSyncDate: lastSyncDate, allGmaxed: allGmaxed, twentyEggsReceived: twentyEggsReceived, hundredThousandStepsWalked: hundredThousandStepsWalked, millionStepsWalked: millionStepsWalked, notificationsEnabled: notificationsEnabled);
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(availableEggs, forKey: "availableEggs")
        aCoder.encode(pokemon, forKey: "pokemon")
        aCoder.encode(noMoreEggs, forKey: "noMoreEggs")
        aCoder.encode(receivedHappiny, forKey: "receivedHappiny")
        aCoder.encode(lastGoalReachedDate, forKey: "lastGoalReachedDate")
        aCoder.encode(lastSyncDate, forKey: "lastSyncDate")
        aCoder.encode(allGmaxed, forKey: "allGmaxed")
        aCoder.encode(twentyEggsReceived, forKey: "twentyEggsReceived")
        aCoder.encode(millionStepsWalked, forKey: "millionStepsWalked")
        aCoder.encode(hundredThousandStepsWalked, forKey: "hundredThousandStepsWalked")
        aCoder.encode(notificationsEnabled, forKey: "notificationsEnabled")
    }
    
    public func getTitle() -> String {
        if (pokemon.count > 29) {
            return "Master";
        } else if (pokemon.count > 19) {
            return "Expert";
        } else if (pokemon.count > 9) {
            return "Medium";
        } else {
            return "Novice";
        }
    }
    
    public func GetLastSyncText() -> String {
        if (lastSyncDate < Date(timeIntervalSince1970: 10)) {
            return "Never";
        } else {
            let formatter = DateFormatter();
            formatter.dateFormat = Pokemon.dateFormatString;
            formatter.amSymbol = "AM";
            formatter.pmSymbol = "PM";
            return formatter.string(from: lastSyncDate);
        }
    }
    
    public func UpdateWalkAchievements() {
        var totalSteps = 0;
        var allPkmnGmaxed = true;
        for pkmn in pokemon {
            totalSteps += pkmn.steps
            if (pkmn.steps < Pokemon.StepsToGmax) {
                allPkmnGmaxed = false
            }
        }
        
        if (totalSteps > 100000) {
            hundredThousandStepsWalked = true;
        }
        if (totalSteps > 1000000) {
            millionStepsWalked = true;
        }
        if (allPkmnGmaxed && noMoreEggs) {
            allGmaxed = true;
        }
    }
}
