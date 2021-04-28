//
//  GoalMetController.swift
//  PDC Hatch WatchKit Extension
//
//  Created by Adrian Impedovo on 28/3/21.
//

import WatchKit
import Foundation


class GoalMetController: WKInterfaceController {
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)

    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        let index = Int(arc4random_uniform(UInt32(User.Player.availableEggs.count)));
        let pokemon = User.Player.availableEggs.remove(at: index)
        User.Player.pokemon.append(Pokemon(id: pokemon));
        
        if (User.Player.pokemon.count > 20) {
            User.Player.twentyEggsReceived = true;
        }
        
        if (User.Player.availableEggs.count == 0) {
            if (User.Player.receivedHappiny) {
                User.Player.noMoreEggs = true;
                UserDefaults.standard.set(true, forKey: ExtensionDelegate.allEggsReceivedKey)
            } else {
                User.Player.availableEggs.append(24);
                User.Player.receivedHappiny = true;
            }
        }
        
        UserDefaults.standard.set(Date(), forKey: ExtensionDelegate.tenThousandStepsNotificationKey)
        UserDefaults.standard.synchronize();
        User.Save();
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
