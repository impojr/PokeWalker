//
//  ExtensionDelegate.swift
//  PDC Hatch WatchKit Extension
//
//  Created by Adrian Impedovo on 15/3/21.
//

import WatchKit
import UserNotifications
import ClockKit

class ExtensionDelegate: NSObject, WKExtensionDelegate {
    static let backgroundRefreshKey = "BGREFRESH"
    static let fiveThousandStepsNotificationKey = "5000STEPS"
    static let nineThousandStepsNotificationKey = "9000STEPS"
    static let tenThousandStepsNotificationKey = "10000STEPS"
    static let allEggsReceivedKey = "ALLEGGSRECEIVED"
    
    func applicationDidFinishLaunching() {
        // Perform any final initialization of your application.
        print("applicationDidFinishLaunching")
        
        if(!UserDefaults.standard.bool(forKey: "firstlaunch1.0")){
            //Put any code here and it will be executed only once.
            UserDefaults.standard.set(true, forKey: "firstlaunch1.0")
            UserDefaults.standard.synchronize();
            
            let truncated = Calendar.current.startOfDay(for: Date())
            print(truncated)
            
            User.Player = User();
            User.Player.lastSyncDate = truncated;
            
            let center = UNUserNotificationCenter.current()
            center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
                User.Player.notificationsEnabled = granted;
                if (granted) {
                    WKExtension.shared().registerForRemoteNotifications();
                }
                User.Save();
            }
            
            User.Save();
        } else {
            User.Load()
        }
    }

    func applicationDidBecomeActive() {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillResignActive() {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, etc.
        if (UserDefaults.standard.object(forKey: ExtensionDelegate.backgroundRefreshKey) == nil) {
            //set to next hour
            let preferredDate = Date().nextHour;
            UserDefaults.standard.set(preferredDate, forKey: ExtensionDelegate.backgroundRefreshKey)
            
            WKExtension.shared().scheduleBackgroundRefresh(withPreferredDate: preferredDate, userInfo: nil) { (error) in
                  if (error == nil) {
                      print("successfully scheduled background task.")
                  }
            }
        } else {
            //check if current date is less than stored date
            let lastRefreshDate = UserDefaults.standard.object(forKey: ExtensionDelegate.backgroundRefreshKey) as! Date
            if (lastRefreshDate < Date()) {
                print("manually rescheduling background task");
                let preferredDate = lastRefreshDate.nextHour;
                UserDefaults.standard.set(preferredDate, forKey: ExtensionDelegate.backgroundRefreshKey)
                
                WKExtension.shared().scheduleBackgroundRefresh(withPreferredDate: preferredDate, userInfo: nil) { (error) in
                      if (error == nil) {
                          print("successfully scheduled background task.")
                      }
                }
            }
        }
    }

    func handle(_ backgroundTasks: Set<WKRefreshBackgroundTask>) {
        // Sent when the system needs to launch the application in the background to process tasks. Tasks arrive in a set, so loop through and process each one.
        for task in backgroundTasks {
            // Use a switch statement to check the task type
            switch task {
            case let backgroundTask as WKApplicationRefreshBackgroundTask:
                // Be sure to complete the background task once you’re done.
                
                //
                let syncDate = Date()
                
                let HKM = HealthKitManager()
                HKM.recentSteps(User.Player.lastSyncDate, endDate: syncDate) { steps, error in
                    let stepsToGive = Int(steps)
                    User.Player.pokemon[0].walk(steps: stepsToGive)
                    print("steps " + String(steps))
                    
                    User.Player.UpdateWalkAchievements()
                    User.Player.lastSyncDate = syncDate
                    User.Save()
                    
                    let complicationServer = CLKComplicationServer.sharedInstance()
                    complicationServer.activeComplications?.forEach({ (complication) in
                        complicationServer.reloadTimeline(for: complication)
                    })
                    
                    self.scheduleNotifications()
                    
                    let preferredDate = syncDate.nextHour;
                    UserDefaults.standard.set(preferredDate, forKey: ExtensionDelegate.backgroundRefreshKey)
                    
                    WKExtension.shared().scheduleBackgroundRefresh(withPreferredDate: preferredDate, userInfo: nil) { (error) in
                          if (error == nil) {
                              print("successfully scheduled background task.")
                              //backgroundTask.setTaskCompletedWithSnapshot(false)
                          }
                    }
                }
                backgroundTask.setTaskCompletedWithSnapshot(false)
                
            case let snapshotTask as WKSnapshotRefreshBackgroundTask:
                // Snapshot tasks have a unique completion call, make sure to set your expiration date
                snapshotTask.setTaskCompleted(restoredDefaultState: true, estimatedSnapshotExpiration: Date.distantFuture, userInfo: nil)
            case let connectivityTask as WKWatchConnectivityRefreshBackgroundTask:
                // Be sure to complete the connectivity task once you’re done.
                connectivityTask.setTaskCompletedWithSnapshot(false)
            case let urlSessionTask as WKURLSessionRefreshBackgroundTask:
                // Be sure to complete the URL session task once you’re done.
                urlSessionTask.setTaskCompletedWithSnapshot(false)
            case let relevantShortcutTask as WKRelevantShortcutRefreshBackgroundTask:
                // Be sure to complete the relevant-shortcut task once you're done.
                relevantShortcutTask.setTaskCompletedWithSnapshot(false)
            case let intentDidRunTask as WKIntentDidRunRefreshBackgroundTask:
                // Be sure to complete the intent-did-run task once you're done.
                intentDidRunTask.setTaskCompletedWithSnapshot(false)
            default:
                // make sure to complete unhandled task types
                task.setTaskCompletedWithSnapshot(false)
            }
        }
    }

    func scheduleNotifications() {
        if(UserDefaults.standard.bool(forKey: ExtensionDelegate.allEggsReceivedKey)) {
            return;
        }
        
        if((UserDefaults.standard.object(forKey: ExtensionDelegate.tenThousandStepsNotificationKey)) != nil) {
            let lastDateNotified = UserDefaults.standard.object(forKey: ExtensionDelegate.tenThousandStepsNotificationKey) as! Date
            
            if (lastDateNotified.isToday) {
                return;
            }
        }
        
        let center = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent();
        
        let HKM = HealthKitManager()
        HKM.TodayTotalSteps() {todaySteps in
            let dailySteps = Int(todaySteps)
            
            if (dailySteps >= HealthKitManager.dailyStepGoal) {
                content.title = "Goal Met";
                content.body = "Great Job!\nGo to the Home Screen and claim your egg!";
                UserDefaults.standard.set(Date(), forKey: ExtensionDelegate.tenThousandStepsNotificationKey)
                UserDefaults.standard.synchronize();
            } else if (dailySteps > 9000) {
                if((UserDefaults.standard.object(forKey: ExtensionDelegate.nineThousandStepsNotificationKey)) != nil) {
                    let lastDateNotified = UserDefaults.standard.object(forKey: ExtensionDelegate.nineThousandStepsNotificationKey) as! Date
                    
                    if (!lastDateNotified.isToday) {
                        content.title = "Nearly There!";
                        content.body = "You're so close to the goal!\nKeep going!";
                        UserDefaults.standard.set(Date(), forKey: ExtensionDelegate.nineThousandStepsNotificationKey)
                        UserDefaults.standard.synchronize();
                    } else {
                        return
                    }
                } else {
                    content.title = "Nearly There!";
                    content.body = "You're so close to the goal!\nKeep going!";
                    UserDefaults.standard.set(Date(), forKey: ExtensionDelegate.nineThousandStepsNotificationKey)
                    UserDefaults.standard.synchronize();
                }
            } else if (dailySteps > 5000) {
                if((UserDefaults.standard.object(forKey: ExtensionDelegate.fiveThousandStepsNotificationKey)) != nil) {
                    let lastDateNotified = UserDefaults.standard.object(forKey: ExtensionDelegate.fiveThousandStepsNotificationKey) as! Date
                    
                    if (!lastDateNotified.isToday) {
                        content.title = "Half-way";
                        content.body = "Keep stepping!\nYou're halfway to the goal!";
                        UserDefaults.standard.set(Date(), forKey: ExtensionDelegate.fiveThousandStepsNotificationKey)
                        UserDefaults.standard.synchronize();
                    } else {
                        return
                    }
                } else {
                    content.title = "Half-way";
                    content.body = "Keep stepping!\nYou're halfway to the goal!";
                    UserDefaults.standard.set(Date(), forKey: ExtensionDelegate.fiveThousandStepsNotificationKey)
                    UserDefaults.standard.synchronize();
                }
            } else {
                return;
            }
            
            let date = Date().addingTimeInterval(30)
            let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
            
            let uuidString = UUID().uuidString
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false);
            let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)
            
            center.add(request) {(error) in
                //check and handle errors
                if (error == nil) {
                    print("scheduled notification a")
                }
            }
        }
    }
}

extension Date {
    public var nextHour: Date {
        let calendar = Calendar.current
        let minutes = calendar.component(.minute, from: self)
        let seconds = calendar.component(.second, from: self)
        let components = DateComponents(hour: 1, minute: -minutes, second: -seconds)
        return calendar.date(byAdding: components, to: self) ?? self
    }
    
    public var isToday: Bool {
        let diff = Calendar.current.dateComponents([.day], from: self, to: Date())
        return diff.day == 0
    }
}
