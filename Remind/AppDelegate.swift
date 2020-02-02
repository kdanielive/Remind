//
//  AppDelegate.swift
//  Remind
//
//  Created by Daniel Kim on 1/26/20.
//  Copyright © 2020 Daniel Kim. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {    return false   }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Event")
        /*
        //Deleting part
        do {
            let test = try managedContext.fetch(fetchRequest)
            let objectToDelete = test[0] as! NSManagedObject
            managedContext.delete(objectToDelete)
            do {
                try managedContext.save()
            } catch {
                print(error)
            }
        } catch {
            print(error)
        }
        */

        // Saving to local part
        do {
            let result = try managedContext.fetch(fetchRequest)
            for data in result as! [NSManagedObject] {
                let tupl = ((data.value(forKey: "personName") as! String),(data.value(forKey: "personRelation") as! String),(data.value(forKey: "eventName") as! String),(data.value(forKey: "date") as! Date),(data.value(forKey: "annual") as! Bool))
                
                if(dataDict.keys.contains(data.value(forKey: "personName") as! String)) {
                    dataDict[data.value(forKey: "personName") as! String]?.append(tupl)
                } else {
                    dataDict[data.value(forKey: "personName") as! String] = [tupl]
                }
                
                relationDict[data.value(forKey: "personRelation") as! String]?.append(tupl)

                
                totalList.append(tupl)
            }
        } catch {
            print("Failed")
        }

        // Generating today list and upcoming list
        for entry in dataDict.keys {
            
            let f = ISO8601DateFormatter()
            f.formatOptions = [.withFullDate, .withDashSeparatorInDate]
            f.timeZone = TimeZone.current
            
            let tuplLst = dataDict[entry]!
            
            for tupl in tuplLst {
                let today = Date()
                let target = tupl.3
                let annual = tupl.4
                
                if(annual) {
                    let formattedToday = f.string(from: today).substring(from: 5)
                    let formattedTarget = f.string(from: target).substring(from: 5)
                    if(formattedToday==formattedTarget) {
                        todayList.append(tupl)
                    }
                } else {
                    let formattedToday = f.string(from: today)
                    let formattedTarget = f.string(from:target)
                    if(formattedToday==formattedTarget) {
                        todayList.append(tupl)
                    }
                }
            }
        }

        for tupl in totalList {
            let date = tupl.3
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy"
            let year = dateFormatter.string(from: date)
            
            dateFormatter.dateFormat = "LLLL"
            let month = dateFormatter.string(from: date)
            
            dateFormatter.dateFormat = "EEEE"
            let weekday = dateFormatter.string(from: date)
            
            let calendar = Calendar.current
            let components = calendar.dateComponents([.day], from: date)
            let day = components.day!
            
            let tempTupl = (Int(year)!,month,Int(day),weekday,tupl)
            dateTuplList.append(tempTupl)
        }
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Remind")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

