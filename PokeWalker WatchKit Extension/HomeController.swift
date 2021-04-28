//
//  HomeController.swift
//  PDC Hatch WatchKit Extension
//
//  Created by Adrian Impedovo on 21/3/21.
//

import WatchKit
import Foundation
import HealthKit
import UserNotifications

class HomeController: WKInterfaceController {

    let HKM = HealthKitManager()
    
    @IBOutlet weak var playerImage: WKInterfaceImage!
    @IBOutlet weak var playerName: WKInterfaceLabel!
    @IBOutlet weak var walkerTitle: WKInterfaceLabel!
    @IBOutlet weak var AllEggsReceived: WKInterfaceImage!
    @IBOutlet weak var partnerImage: WKInterfaceButton!
    @IBOutlet weak var hundredThousandSteps: WKInterfaceImage!
    @IBOutlet weak var millionSteps: WKInterfaceImage!
    @IBOutlet weak var twentyEggs: WKInterfaceImage!
    @IBOutlet weak var allGmaxed: WKInterfaceImage!
    @IBOutlet weak var selectCharacter: WKInterfaceLabel!
    @IBOutlet weak var Adrian: WKInterfaceButton!
    @IBOutlet weak var Rynier: WKInterfaceButton!
    @IBOutlet weak var Elisa: WKInterfaceButton!
    @IBOutlet weak var Nate: WKInterfaceButton!
    
    @IBAction func AdrianPressed() {
        User.Player.name = "Adrian";
        let partnerId = 13;
        User.Player.pokemon.append(Pokemon(id: partnerId));
        let index = User.Player.availableEggs.firstIndex(of: partnerId)!;
        User.Player.availableEggs.remove(at: index);
        User.Save();
        willActivate();
    }
    
    @IBAction func RynierPressed() {
        User.Player.name = "Rynier";
        let partnerId = 29;
        User.Player.pokemon.append(Pokemon(id: partnerId));
        let index = User.Player.availableEggs.firstIndex(of: partnerId)!;
        User.Player.availableEggs.remove(at: index);
        User.Save();
        willActivate();
    }
    
    @IBAction func ElisaPressed() {
        User.Player.name = "Elisa";
        let partnerId = 69;
        User.Player.pokemon.append(Pokemon(id: partnerId));
        let index = User.Player.availableEggs.firstIndex(of: partnerId)!;
        User.Player.availableEggs.remove(at: index);
        User.Save();
        willActivate();
    }
    
    @IBAction func NatePressed() {
        User.Player.name = "Nate";
        let partnerId = 59;
        User.Player.pokemon.append(Pokemon(id: partnerId));
        let index = User.Player.availableEggs.firstIndex(of: partnerId)!;
        User.Player.availableEggs.remove(at: index);
        User.Save();
        willActivate();
    }
    
    @IBAction func Partner() {
        pushController(withName: "PokemonController", context: 0);
    }
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        if (User.Player.name == "") {
            playerImage.setHidden(true);
            playerName.setHidden(true);
            partnerImage.setHidden(true);
            walkerTitle.setHidden(true);
            AllEggsReceived.setHidden(true);
            hundredThousandSteps.setHidden(true);
            millionSteps.setHidden(true);
            twentyEggs.setHidden(true);
            allGmaxed.setHidden(true);
        } else {
            selectCharacter.setHidden(true);
            Adrian.setHidden(true);
            Elisa.setHidden(true);
            Rynier.setHidden(true);
            Nate.setHidden(true);
            playerImage.setHidden(false);
            playerName.setHidden(false);
            partnerImage.setHidden(false);
            walkerTitle.setHidden(false);
            
            playerImage.setImage(UIImage(imageLiteralResourceName: User.Player.name))
            playerName.setText(User.Player.name);
            
            let pokemon = User.Player.pokemon[0];
            partnerImage.setBackgroundImage(UIImage(imageLiteralResourceName: pokemon.getSpriteString()));
            walkerTitle.setText(User.Player.getTitle() + " Walker");
            AllEggsReceived.setHidden(!User.Player.noMoreEggs);
            hundredThousandSteps.setHidden(!User.Player.hundredThousandStepsWalked);
            millionSteps.setHidden(!User.Player.millionStepsWalked);
            twentyEggs.setHidden(!User.Player.twentyEggsReceived);
            allGmaxed.setHidden(!User.Player.allGmaxed);
            
            if (!User.Player.noMoreEggs) {
                let calendar = Calendar.current;
                if (calendar.isDateInToday(User.Player.lastGoalReachedDate)) {
                    print("Goal already reached today")
                } else {
                    var goalReached = false;
                    HKM.TodayTotalSteps() {todaySteps in
                        goalReached = Int(todaySteps) >= HealthKitManager.dailyStepGoal
                        
                        if (goalReached) {
                            User.Player.lastGoalReachedDate = Date()
                            self.pushController(withName: "GoalMetController", context: nil)
                        }
                    }
                }
            }
        }
    }
    

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
}
