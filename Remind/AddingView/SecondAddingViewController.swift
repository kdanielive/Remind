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
        } else {
            annualButton.backgroundColor = UIColor.black
            annualButtonState = true
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
                savePermanent()
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
    
    func savePermanent() {
        if(eventTupleList.count != 0) {
            for event in eventTupleList {
                createData(date: event.0, annual: event.1, eventName: event.2, personName: event.3)
            }
            eventTupleList.removeAll()
        }
        createData(name: currentPersonName!, relation: currentRelation!)
    }
    
    func saveEventTuple(date:Date, annual:Bool, eventName:String, personName:String) {
        eventTupleList.append((date, annual, eventName, personName))
    }
    
    func createData(date:Date, annual:Bool, eventName:String, personName:String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {    return  }
        let managedContext = appDelegate.persistentContainer.viewContext
        let eventEntity = NSEntityDescription.entity(forEntityName: "Event", in: managedContext)!
        let event = NSManagedObject(entity: eventEntity, insertInto: managedContext)
        event.setValue(date, forKey: "date")
        event.setValue(annual, forKey: "annual")
        event.setValue(eventName, forKey: "eventName")
        event.setValue(personName, forKey: "personName")
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
