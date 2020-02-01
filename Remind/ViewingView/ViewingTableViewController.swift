//
//  ViewingTableViewController.swift
//  Remind
//
//  Created by Daniel Kim on 1/26/20.
//  Copyright © 2020 Daniel Kim. All rights reserved.
//

import UIKit
import CoreData

class ViewingTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.backgroundColor = UIColor.init(red: 0/255, green: 49/255, blue: 82/255, alpha: 1)

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
        return viewTuplList.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "viewcell", for: indexPath) as! ViewingTableViewCell
        cell.backgroundColor = UIColor.init(red: 0/255, green: 49/255, blue: 82/255, alpha: 1)

        // Configure the cell...
        let tupl = viewTuplList[indexPath.row]
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
        
        let moreImageView = UIImageView(image: UIImage(named: "icon9"))
        cell.accessoryView = moreImageView

        return cell
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
