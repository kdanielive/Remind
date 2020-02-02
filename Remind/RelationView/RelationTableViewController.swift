//
//  RelationTableViewController.swift
//  Remind
//
//  Created by Daniel Kim on 2/2/20.
//  Copyright © 2020 Daniel Kim. All rights reserved.
//
// "Family", "Lover", "Partner in Life", "Close Friend", "Friend", "Work", "School", "Acquaintance"

import UIKit

class RelationTableViewController: UITableViewController {
    
    let relationKeys = ["Family", "Lover", "Partner in Life", "Close Friend", "Friend", "Work", "School", "Acquaintance"]
    var currentRelation = "Family"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.backgroundColor = UIColor.init(red: 0/255, green: 49/255, blue: 82/255, alpha: 1)

        NotificationCenter.default.addObserver(self, selector: Selector("reload"), name: Notification.Name("reloadLocalDataCompleted"), object: nil)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    @objc func reload() {
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 8
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if(section==0) {
            return relationDict["Family"]!.count
        } else if (section==1) {
            return relationDict["Lover"]!.count
        } else if (section==2) {
            return relationDict["Partner in Life"]!.count
        } else if (section==3) {
            return relationDict["Close Friend"]!.count
        } else if (section==4) {
            return relationDict["Friend"]!.count
        } else if (section==5) {
            return relationDict["Work"]!.count
        } else if (section==6) {
            return relationDict["School"]!.count
        } else {
            return relationDict["Acquaintance"]!.count
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "relationcell", for: indexPath) as! RelationTableViewCell
        cell.backgroundColor = UIColor.init(red: 0/255, green: 49/255, blue: 82/255, alpha: 1)
        cell.selectionStyle = .none

        // Configure the cell...
        let relationKey = relationKeys[indexPath.section]
        let tupl = relationDict[relationKey]![indexPath.row]
        let padding = CGFloat(5)
        
        let nameLabel = UILabel()
        nameLabel.frame = CGRect(x: padding*3, y: padding, width: 0, height: 0)
        nameLabel.text = tupl.0
        nameLabel.textColor = UIColor.white
        nameLabel.font = UIFont(name: "Noteworthy-Bold", size: 20)
        nameLabel.sizeToFit()
        cell.addSubview(nameLabel)
        
        let nameLabelHeight = nameLabel.frame.height
        let nameLabelWidth = nameLabel.frame.width
        let eventLabel = UILabel()
        eventLabel.frame = CGRect(x: padding*3, y: padding+nameLabelHeight, width: 0, height: 0)
        eventLabel.text = tupl.2
        eventLabel.textColor = UIColor.white
        eventLabel.font = UIFont.systemFont(ofSize: 12)
        eventLabel.sizeToFit()
        cell.addSubview(eventLabel)
        
        let date = tupl.3
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        let year = dateFormatter.string(from: date)
        let dateLabel = UILabel()
        dateLabel.frame = CGRect(x: padding*5+eventLabel.frame.width, y: padding+nameLabelHeight, width: 0, height: 0)
        if(tupl.4) {
            dateLabel.text = "Annual"
        } else  {
            dateLabel.text = year
        }
        dateLabel.textColor = UIColor.white
        dateLabel.font = UIFont.systemFont(ofSize: 12)
        dateLabel.sizeToFit()
        cell.addSubview(dateLabel)
        
        /*
        let accessoryButton = UIButton()
        accessoryButton.tag = indexPath.row
        accessoryButton.setImage(UIImage(named: "icon9"), for: .normal)
        accessoryButton.frame = CGRect(x: cell.frame.width-CGFloat(50), y: CGFloat(15), width: CGFloat(30), height: CGFloat(30))
        accessoryButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        cell.addSubview(accessoryButton)
         */

        return cell
    }
    
    /*
    @objc func buttonTapped(sender: UIButton) {
        deleteTargetTupl = viewTuplList[sender.tag]
        
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let popVC = storyboard.instantiateViewController(withIdentifier: "PopoverViewController")
        
        popVC.modalPresentationStyle = .popover
        
        let popOverVC = popVC.popoverPresentationController
        popOverVC?.delegate = self
        popOverVC?.permittedArrowDirections = .up
        popOverVC?.sourceView = sender
        popOverVC?.sourceRect = CGRect(x: sender.bounds.midX, y: sender.bounds.midY, width: 0, height: 0)
        popVC.preferredContentSize = CGSize(width: 150, height: 40)

        self.present(popVC, animated: true)
    }
    */
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    /*
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return relationKeys[section]
    }
    */
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = MainViewHeaderCard()
        header.backgroundColor = UIColor.init(red: 0/255, green: 49/255, blue: 82/255, alpha: 1)
        header.titleLabel.textColor = UIColor.white
        
        let line = UIView()
        line.frame = CGRect(x: CGFloat(10), y: 0, width: self.tableView.frame.width-CGFloat(20), height: CGFloat(1))
        line.backgroundColor = UIColor.white
        header.addSubview(line)
        
        header.titleLabel.text = relationKeys[section]
        
        return header

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

extension RelationTableViewController: UIPopoverPresentationControllerDelegate {

    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}
