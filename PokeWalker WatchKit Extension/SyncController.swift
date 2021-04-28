//
//  SyncController.swift
//  PDC Hatch WatchKit Extension
//
//  Created by Adrian Impedovo on 27/3/21.
//

import WatchKit
import Foundation
import ClockKit

class SyncController: WKInterfaceController {

    let HKM = HealthKitManager()
    
    @IBOutlet weak var partnerImage: WKInterfaceImage!
    @IBOutlet weak var partnerName: WKInterfaceLabel!
    @IBOutlet weak var syncButton: WKInterfaceButton!
    @IBOutlet weak var lastSync: WKInterfaceLabel!
    
    @IBOutlet weak var dailyGoalLabel: WKInterfaceLabel!
    @IBOutlet weak var dailyGoalFirst: WKInterfaceImage!
    @IBOutlet weak var dailyGoalLast: WKInterfaceImage!
    @IBOutlet weak var congratsMessage: WKInterfaceLabel!
    
    @IBAction func Sync() {
        let syncDate = Date()
        
        HKM.recentSteps(User.Player.lastSyncDate, endDate: syncDate) { steps, error in
            let stepsToGive = Int(steps)
            User.Player.pokemon[0].walk(steps: stepsToGive)
            print("steps " + String(steps))
        
            let complicationServer = CLKComplicationServer.sharedInstance()
            complicationServer.activeComplications?.forEach({ (complication) in
                complicationServer.reloadTimeline(for: complication)
            })
        
            User.Player.UpdateWalkAchievements()
            User.Player.lastSyncDate = syncDate
            User.Save() 
            self.willActivate()
        }
    }
    
    @IBOutlet weak var GetPokemon: WKInterfaceButton!
    
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        if (User.Player.name == "") {
            return;
        }
        
        let pokemon = User.Player.pokemon[0]
        partnerImage.setImage(UIImage(imageLiteralResourceName: pokemon.getIconString()))
        partnerName.setText(pokemon.getName())
        
        lastSync.setText("Last Sync:\n" + User.Player.GetLastSyncText());
        
        //ONLY FOR DEBUGGING
        //GetPokemon.setHidden(User.Player.noMoreEggs)
        dailyGoalLabel.setHidden(User.Player.noMoreEggs)
        dailyGoalFirst.setHidden(User.Player.noMoreEggs)
        dailyGoalLast.setHidden(User.Player.noMoreEggs)
        congratsMessage.setHidden(!User.Player.noMoreEggs)
        
        updateDailyStepsPercent();
        
        //if last sync less than 10 minutes ago, hide button
        let tenMinsAgo = Calendar.current.date(
          byAdding: .minute,
          value: -10,
            to: Date())!
        syncButton.setHidden(User.Player.lastSyncDate > tenMinsAgo)
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    func updateDailyStepsPercent() {
        //get days current steps
        var currentDailySteps = 0;
        HKM.TodayTotalSteps() {todaySteps in
            currentDailySteps = Int(todaySteps)
            print("currentDailySteps " + String(currentDailySteps))
            
            var stepGoalPercentFirst = 0.0;
            
            if (currentDailySteps >= HealthKitManager.dailyStepGoal) {
                stepGoalPercentFirst = 1
            } else {
                stepGoalPercentFirst = Double(currentDailySteps) / Double(HealthKitManager.dailyStepGoal)
            }
            
            let stepGoalPercentLast = 1 - stepGoalPercentFirst;
            self.dailyGoalFirst.setRelativeWidth(CGFloat(stepGoalPercentFirst), withAdjustment: 0);
            self.dailyGoalLast.setRelativeWidth(CGFloat(stepGoalPercentLast), withAdjustment: 0);
        }
    }
}
