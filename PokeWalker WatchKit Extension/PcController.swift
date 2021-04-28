//
//  PcController.swift
//  PDC Hatch WatchKit Extension
//
//  Created by Adrian Impedovo on 21/3/21.
//

import WatchKit
import Foundation


class PcController: WKInterfaceController {
    
    @IBOutlet weak var count: WKInterfaceLabel!
    
    @IBOutlet weak var button1: WKInterfaceButton!
    @IBOutlet weak var button2: WKInterfaceButton!
    @IBOutlet weak var button3: WKInterfaceButton!
    @IBOutlet weak var button4: WKInterfaceButton!
    @IBOutlet weak var button5: WKInterfaceButton!
    @IBOutlet weak var button6: WKInterfaceButton!
    @IBOutlet weak var button7: WKInterfaceButton!
    @IBOutlet weak var button8: WKInterfaceButton!
    @IBOutlet weak var button9: WKInterfaceButton!
    @IBOutlet weak var button10: WKInterfaceButton!
    @IBOutlet weak var button11: WKInterfaceButton!
    @IBOutlet weak var button12: WKInterfaceButton!
    @IBOutlet weak var button13: WKInterfaceButton!
    @IBOutlet weak var button14: WKInterfaceButton!
    @IBOutlet weak var button15: WKInterfaceButton!
    @IBOutlet weak var button16: WKInterfaceButton!
    @IBOutlet weak var button17: WKInterfaceButton!
    @IBOutlet weak var button18: WKInterfaceButton!
    @IBOutlet weak var button19: WKInterfaceButton!
    @IBOutlet weak var button20: WKInterfaceButton!
    @IBOutlet weak var button21: WKInterfaceButton!
    @IBOutlet weak var button22: WKInterfaceButton!
    @IBOutlet weak var button23: WKInterfaceButton!
    @IBOutlet weak var button24: WKInterfaceButton!
    @IBOutlet weak var button25: WKInterfaceButton!
    @IBOutlet weak var button26: WKInterfaceButton!
    @IBOutlet weak var button27: WKInterfaceButton!
    @IBOutlet weak var button28: WKInterfaceButton!
    @IBOutlet weak var button29: WKInterfaceButton!
    @IBOutlet weak var button30: WKInterfaceButton!
    
    @IBAction func button1Clicked() {
        pushController(withName: "PokemonController", context: 1);
    }
    
    @IBAction func button2Clicked() {
        pushController(withName: "PokemonController", context: 2);
    }
    
    @IBAction func button3Clicked() {
        pushController(withName: "PokemonController", context: 3);
    }
    
    @IBAction func button4Clicked() {
        pushController(withName: "PokemonController", context: 4);
    }
    
    @IBAction func button5Clicked() {
        pushController(withName: "PokemonController", context: 5);
    }
    
    @IBAction func button6Clicked() {
        pushController(withName: "PokemonController", context: 6);
    }
    
    @IBAction func button7Clicked() {
        pushController(withName: "PokemonController", context: 7);
    }
    
    @IBAction func button8Clicked() {
        pushController(withName: "PokemonController", context: 8);
    }
    
    @IBAction func button9Clicked() {
        pushController(withName: "PokemonController", context: 9);
    }
    
    @IBAction func button10Clicked() {
        pushController(withName: "PokemonController", context: 10);
    }
    
    @IBAction func button11Clicked() {
        pushController(withName: "PokemonController", context: 11);
    }
    
    @IBAction func button12Clicked() {
        pushController(withName: "PokemonController", context: 12);
    }
    
    @IBAction func button13Clicked() {
        pushController(withName: "PokemonController", context: 13);
    }
    
    @IBAction func button14Clicked() {
        pushController(withName: "PokemonController", context: 14);
    }
    
    @IBAction func button15Clicked() {
        pushController(withName: "PokemonController", context: 15);
    }
    
    @IBAction func button16Clicked() {
        pushController(withName: "PokemonController", context: 16);
    }
    
    @IBAction func button17Clicked() {
        pushController(withName: "PokemonController", context: 17);
    }
    
    @IBAction func button18Clicked() {
        pushController(withName: "PokemonController", context: 18);
    }
    
    @IBAction func button19Clicked() {
        pushController(withName: "PokemonController", context: 19);
    }
    
    @IBAction func button20Clicked() {
        pushController(withName: "PokemonController", context: 20);
    }
    
    @IBAction func button21Clicked() {
        pushController(withName: "PokemonController", context: 21);
    }
    
    @IBAction func button22Clicked() {
        pushController(withName: "PokemonController", context: 22);
    }
    
    @IBAction func button23Clicked() {
        pushController(withName: "PokemonController", context: 23);
    }
    
    @IBAction func button24Clicked() {
        pushController(withName: "PokemonController", context: 24);
    }
    
    @IBAction func button25Clicked() {
        pushController(withName: "PokemonController", context: 25);
    }
    
    @IBAction func button26Clicked() {
        pushController(withName: "PokemonController", context: 26);
    }
    
    @IBAction func button27Clicked() {
        pushController(withName: "PokemonController", context: 27);
    }
    
    @IBAction func button28Clicked() {
        pushController(withName: "PokemonController", context: 28);
    }
    
    @IBAction func button29Clicked() {
        pushController(withName: "PokemonController", context: 29);
    }
    
    @IBAction func button30Clicked() {
        pushController(withName: "PokemonController", context: 30);
    }
    
    
    var buttons: [WKInterfaceButton] = [];
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        buttons.append(button1);
        buttons.append(button2);
        buttons.append(button3);
        buttons.append(button4);
        buttons.append(button5);
        buttons.append(button6);
        buttons.append(button7);
        buttons.append(button8);
        buttons.append(button9);
        buttons.append(button10);
        buttons.append(button11);
        buttons.append(button12);
        buttons.append(button13);
        buttons.append(button14);
        buttons.append(button15);
        buttons.append(button16);
        buttons.append(button17);
        buttons.append(button18);
        buttons.append(button19);
        buttons.append(button20);
        buttons.append(button21);
        buttons.append(button22);
        buttons.append(button23);
        buttons.append(button24);
        buttons.append(button25);
        buttons.append(button26);
        buttons.append(button27);
        buttons.append(button28);
        buttons.append(button29);
        buttons.append(button30);
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        let pcLength = User.Player.pokemon.count - 1;
        
        count.setText("Count: " + String(pcLength));
        
        for n in 0...buttons.count-1 {
            if (pcLength >= n+1) {
                buttons[n].setHidden(false);
                let pokemon = User.Player.pokemon[n+1];
                buttons[n].setBackgroundImage(UIImage(imageLiteralResourceName: pokemon.getIconString()));
            } else {
                buttons[n].setHidden(true);
            }
        }
        
        if (User.Player.name == "") {
            count.setText("Count: 0");
        }
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
