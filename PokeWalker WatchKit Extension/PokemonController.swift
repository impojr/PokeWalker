//
//  PokemonController.swift
//  PDC Hatch WatchKit Extension
//
//  Created by Adrian Impedovo on 21/3/21.
//

import WatchKit
import Foundation
import ClockKit

class PokemonController: WKInterfaceController {

    @IBOutlet weak var pokemonImage: WKInterfaceImage!
    @IBOutlet weak var pokemonName: WKInterfaceLabel!
    @IBOutlet weak var pokemonLevel: WKInterfaceLabel!
    @IBOutlet weak var pokemonSteps: WKInterfaceLabel!
    @IBOutlet weak var pokemonObtained: WKInterfaceLabel!
    @IBOutlet weak var pokemonHatched: WKInterfaceLabel!
    @IBOutlet weak var makePartnerButton: WKInterfaceButton!
    @IBOutlet weak var expGainedFirst: WKInterfaceImage!
    @IBOutlet weak var expGainedLast: WKInterfaceImage!
    @IBOutlet weak var hatchText: WKInterfaceLabel!
    
    @IBAction func makePartner() {
        //take pokemon at array index and push it to front
        let pokemon = User.Player.pokemon.remove(at: arrayIndex);
        User.Player.pokemon.insert(pokemon, at: 0);
        
        let complicationServer = CLKComplicationServer.sharedInstance()
        complicationServer.activeComplications?.forEach({ (complication) in
            complicationServer.reloadTimeline(for: complication)
        })
        
        makePartnerButton.setHidden(true);
        User.Save();
    }
    
//    @IBAction func walk() {
//        print(arrayIndex);
//        let pokemon = User.Player.pokemon[arrayIndex]
//        pokemon.walk(steps: 1000);
//        let encodedData = NSKeyedArchiver.archivedData(withRootObject: User.Player)
//        UserDefaults.standard.set(encodedData, forKey: "player")
//        UserDefaults.standard.synchronize();
//
//        awake(withContext: arrayIndex)
//    }
    
    var arrayIndex: Int = 0;
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        arrayIndex = context as! Int;
        let pokemon = User.Player.pokemon[arrayIndex]
        // Configure interface objects here.
        
        pokemonImage.setImage(UIImage(imageLiteralResourceName: pokemon.getSpriteString()));
        pokemonName.setText(pokemon.getName());

        pokemonSteps.setText(String(pokemon.steps) + " Steps");
        pokemonObtained.setText("Obtained:\n" + pokemon.dateRecieved);
        pokemonHatched.setHidden(pokemon.isEgg());
        pokemonHatched.setText("Hatched:\n" + pokemon.dateHatched);
        
        makePartnerButton.setHidden(arrayIndex == 0)
        
        expGainedFirst.setHidden(pokemon.isEgg())
        expGainedLast.setHidden(pokemon.isEgg())
        pokemonLevel.setHidden(pokemon.isEgg())
        hatchText.setHidden(!pokemon.isEgg())
        if (pokemon.isEgg()) {
            hatchText.setText(pokemon.getHatchText())
        } else {
            pokemonLevel.setText("LVL " + pokemon.getLevelString());
            
            let nextLevelPercentFirst = pokemon.getNextLevelPercent();
            let nextLevelPercentLast = 1 - nextLevelPercentFirst;
            expGainedFirst.setRelativeWidth(CGFloat(nextLevelPercentFirst), withAdjustment: 0);
            expGainedLast.setRelativeWidth(CGFloat(nextLevelPercentLast), withAdjustment: 0);
        }
        

    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
