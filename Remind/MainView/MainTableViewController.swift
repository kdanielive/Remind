//
//  MainTableViewController.swift
//  Remind
//
//  Created by Daniel Kim on 1/26/20.
//  Copyright © 2020 Daniel Kim. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.backgroundColor = UIColor.darkGray
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if(section==0) {
            if(todayList.count==0) {
                return 1
            }
            return todayList.count
        }
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "maincell", for: indexPath) as! MainTableViewCell
        //cell.backgroundColor = UIColor.darkGray
        cell.backgroundColor = UIColor.init(red: 0/255, green: 49/255, blue: 82/255, alpha: 1)
        
        if(indexPath.section==0) {
            if(todayList.count == 0) {
                let noneLabel = UILabel()
                noneLabel.frame = CGRect(x: 0, y: 0, width: cell.frame.width, height: cell.frame.height)
                noneLabel.font = UIFont.italicSystemFont(ofSize: 18)
                noneLabel.text = "  None"
                cell.addSubview(noneLabel)
            } else {
                
            }
        } else {
            let contentView = MainViewActionCard()
            var padding = CGFloat(0)
            let viewWidth = cell.contentView.frame.width - padding*2
            let viewHeight = cell.contentView.frame.height - padding*2
            contentView.frame = CGRect(x: padding, y: padding, width: viewWidth, height: viewHeight)
            
            if(indexPath.row==0) {
                contentView.titleLabel.text = "Add"
                contentView.iconImageView.image = UIImage(named: "icon3")
                contentView.nameLabel.text = "Click to add Persons"
            } else {
                contentView.titleLabel.text = "View"
                contentView.iconImageView.image = UIImage(named: "icon4")
                contentView.nameLabel.text = "Click to view Persons"
            }
            
            cell.addSubview(contentView)
        }
        // Configure the cell...
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = MainViewHeaderCard()
        header.backgroundColor = UIColor.init(red: 0/255, green: 49/255, blue: 82/255, alpha: 1)
        header.titleLabel.text = "Today"
        header.titleLabel.textColor = UIColor.white
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.section==0) {
            if(todayList.count == 0) {
                return 30
            } else {
                return 100
            }
        } else {
            return 140
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = indexPath.section
        let row = indexPath.row
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        if(section==1) {
            if(row==0) {
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "addingviewnav") as! UINavigationController
                self.present(nextViewController, animated:false, completion:nil)
            } else {
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "viewingviewnav") as! UINavigationController
                self.present(nextViewController, animated:false, completion:nil)
            }
        }
    }
    
    @IBAction func unwindToMain(segue:UIStoryboardSegue) { }

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
