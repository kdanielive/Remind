//
//  SecondAddingViewController.swift
//  Remind
//
//  Created by Daniel Kim on 1/26/20.
//  Copyright © 2020 Daniel Kim. All rights reserved.
//

import UIKit
import CoreData

class SecondAddingViewController: UIViewController, UITextFieldDelegate {
    
    var annualButtonState = true

    @IBOutlet var annualButton: UIButton!
    @IBOutlet var datePicker: UIDatePicker!
    
    var date: Date?
    var annual = true
    var eventName: String?
    
    @IBOutlet var eventTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.eventTextField.delegate = self
        
        annualButton.backgroundColor = UIColor.black
        annualButton.layer.borderColor = UIColor.black.cgColor
        annualButton.layer.borderWidth = 1
        annualButton.layer.roundCorners(radius: 5)
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func dateValueChanged(_ sender: UIDatePicker) {
        date = sender.date
    }
    
    @IBAction func annualEventButtonTouched(_ sender: UIButton) {
        if(annualButtonState) {
            annualButton.backgroundColor = UIColor.clear
            annualButtonState = false
            annual = false
        } else {
            annualButton.backgroundColor = UIColor.black
            annualButtonState = true
            annual = true
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if(identifier=="unwindToAddingView") {
            eventTupleList.removeAll()
            return true
        } else if(identifier=="reload"){
            if(eventName != nil && date != nil) {
                saveEventTuple(date: date!, annual: annual, eventName: eventName!, personName: currentPersonName!)
                return true
            } else {
                showAlert()
                return false
            }
        } else {
            if(eventName != nil && date != nil) {
                saveEventTuple(date: date!, annual: annual, eventName: eventName!, personName: currentPersonName!)
                savePermanent()
                reloadLocalData()
                return true
            } else {
                showAlert()
                return false
            }
        }
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "", message: "Set both detail description and the date", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Redo", style: .default, handler: nil))
        self.navigationController?.present(alert, animated: false, completion: nil)
    }
    
    func reloadLocalData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {    return    }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Event")
        
        totalList.removeAll()
        dataDict.removeAll()
        todayList.removeAll()
        dateTuplList.removeAll()
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            for data in result as! [NSManagedObject] {
                let tupl = ((data.value(forKey: "personName") as! String),(data.value(forKey: "personRelation") as! String),(data.value(forKey: "eventName") as! String),(data.value(forKey: "date") as! Date),(data.value(forKey: "annual") as! Bool))
                
                if(dataDict.keys.contains(data.value(forKey: "personName") as! String)) {
                    dataDict[data.value(forKey: "personName") as! String]?.append(tupl)
                    relationDict[data.value(forKey: "personRelation") as! String]?.append(tupl)
                } else {
                    dataDict[data.value(forKey: "personName") as! String] = [tupl]
                    relationDict[data.value(forKey: "personRelation") as! String] = [tupl]
                }
                
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
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: "reloadLocalDataCompleted"), object: nil)
    }
    
    func savePermanent() {
        if(eventTupleList.count != 0) {
            for event in eventTupleList {
                createData(date: event.0, annual: event.1, eventName: event.2, personName: event.3, personRelation: currentRelation!)
            }
            eventTupleList.removeAll()
        }
    }
    
    func saveEventTuple(date:Date, annual:Bool, eventName:String, personName:String) {
        eventTupleList.append((date, annual, eventName, personName))
    }
    
    func createData(date:Date, annual:Bool, eventName:String, personName:String, personRelation:String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {    return  }
        let managedContext = appDelegate.persistentContainer.viewContext
        let eventEntity = NSEntityDescription.entity(forEntityName: "Event", in: managedContext)!
        let event = NSManagedObject(entity: eventEntity, insertInto: managedContext)
        event.setValue(date, forKey: "date")
        event.setValue(annual, forKey: "annual")
        event.setValue(eventName, forKey: "eventName")
        event.setValue(personName, forKey: "personName")
        event.setValue(personRelation, forKey: "personRelation")
        
        do {
            try managedContext.save()
            print("saved")
        } catch let error as NSError {
            print(error)
        }
    }
    
    func createData(name:String, relation:String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {    return  }
        let managedContext = appDelegate.persistentContainer.viewContext
        let personEntity = NSEntityDescription.entity(forEntityName: "Person", in: managedContext)!
        let person = NSManagedObject(entity: personEntity, insertInto: managedContext)
        person.setValue(name, forKey: "name")
        person.setValue(relation, forKey: "relation")
    }
    
    @IBAction func eventEditingEnded(_ sender: UITextField) {
        eventName = sender.text!.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        eventTextField.resignFirstResponder()
        return true
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
