//
//  AddingViewController.swift
//  Remind
//
//  Created by Daniel Kim on 1/26/20.
//  Copyright © 2020 Daniel Kim. All rights reserved.
//

import UIKit
import CoreData

class AddingViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

    @IBOutlet var relationPickerView: UIPickerView!
    @IBOutlet var nameTextField: UITextField!
    
    let relationVariety = ["Family", "Close Friend", "Friend", "Acquaintance", "Work"]
    var name = ""
    var relation = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.nameTextField.delegate = self
        self.relationPickerView.delegate = self
        self.relationPickerView.dataSource = self
        
        relationPickerView.layer.borderWidth = 0.5
        relationPickerView.layer.borderColor = UIColor.gray.cgColor
        relationPickerView.layer.roundCorners(radius: 5)
        relationPickerView.selectRow(2, inComponent: 0, animated: false)
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func editingEnded(_ sender: UITextField) {
        self.name = sender.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        print(self.name)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        nameTextField.resignFirstResponder()
        return true
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return relationVariety.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return relationVariety[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.relation = relationVariety[row]
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        if(self.name == "") {
            let alert = UIAlertController(title: "", message: "Fill in the blank fields first", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Redo", style: .default, handler: nil))
            self.navigationController?.present(alert, animated: false, completion: nil)
            return false
        } else {
            currentPersonName = self.name
            createData(name: self.name, relation: self.relation)
            return true
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
