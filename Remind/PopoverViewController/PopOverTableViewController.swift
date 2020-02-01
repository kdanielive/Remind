//
//  PopOverTableViewController.swift
//  Remind
//
//  Created by Daniel Kim on 2/1/20.
//  Copyright © 2020 Daniel Kim. All rights reserved.
//

import UIKit
import CoreData

class PopOverTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "popovercell", for: indexPath) as! PopOverTableViewCell
        // Configure the cell...
        
        let deleteButton = UIButton()
        deleteButton.frame = CGRect(x: 0, y: 0, width: cell.frame.width, height: cell.frame.height)
        deleteButton.setTitle("Delete", for: .normal)
        deleteButton.setTitleColor(UIColor.red, for: .normal)
        deleteButton.addTarget(self, action: #selector(deleteReminder), for: .touchUpInside)
        cell.addSubview(deleteButton)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    @objc func deleteReminder() {
        //Deleting part
        let tupl = deleteTargetTupl
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {    return   }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Event")
        if let result = try? managedContext.fetch(fetchRequest) {
            for object in result as! [NSManagedObject]{
                let personName = object.value(forKey: "personName") as! String
                let eventName = object.value(forKey: "eventName") as! String
                let date = object.value(forKey: "date") as! Date
                
                if(personName==tupl.0 && eventName==tupl.2 && date==tupl.3) {
                    managedContext.delete(object)
                }
            }
        }
        do {
            try managedContext.save()
        } catch {
            print("error")
        }

        viewTuplList = viewTuplList.filter {$0 != tupl}
        self.reloadLocalData()
        NotificationCenter.default.post(name: Notification.Name(rawValue: "reloadLocalDataCompleted"), object: nil)
        self.dismiss(animated: true, completion: nil)
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
                } else {
                    dataDict[data.value(forKey: "personName") as! String] = [tupl]
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
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
