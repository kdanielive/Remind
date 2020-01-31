//
//  MainTableViewController.swift
//  Remind
//
//  Created by Daniel Kim on 1/26/20.
//  Copyright © 2020 Daniel Kim. All rights reserved.
//

import UIKit
import Floaty

class MainTableViewController: UITableViewController {
    
    let monthDict = [
        1:"January",
        2:"February",
        3:"March",
        4:"April",
        5:"May",
        6:"June",
        7:"July",
        8:"August",
        9:"September",
        10:"October",
        11:"Novermber",
        12:"December"
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let floaty = Floaty()
        floaty.addItem(title: "Hello, World!")
        floaty.sticky = true
        self.tableView.addSubview(floaty)
        self.tableView.bringSubviewToFront(floaty)

        self.tableView.backgroundColor = UIColor.init(red: 0/255, green: 49/255, blue: 82/255, alpha: 1)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor.init(red: 0/255, green: 49/255, blue: 82/255, alpha: 1)
        
        DispatchQueue.main.async {
            let f = ISO8601DateFormatter()
            f.formatOptions = [.withFullDate, .withDashSeparatorInDate]
            f.timeZone = TimeZone.current
            let month = Int(f.string(from: Date()).substring(from: 5).substring(to: 2))!
            let day = Int(f.string(from: Date()).substring(from: 8).substring(to: 2))!
            
            let indexPath:IndexPath = IndexPath(row: day-1, section: month)
            self.tableView.scrollToRow(at: indexPath, at: .none, animated: false)
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 13
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let specialMonths = [4,6,9,11]
        if(section==0) {
            if(todayList.count==0) {
                return 1
            }
            return todayList.count
        } else if(section==2) {
            return 29
        } else if(specialMonths.contains(section)){
            return 30
        } else {
            return 31
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "maincell", for: indexPath) as! MainTableViewCell
        //cell.backgroundColor = UIColor.darkGray
        if(indexPath.row % 2 == 0) {
            cell.backgroundColor = UIColor.init(red: 0/255, green: 49/255, blue: 82/255, alpha: 1)
        } else {
            cell.backgroundColor = UIColor.init(red: 30/255, green: 59/255, blue: 92/255, alpha: 1)
        }

        if(indexPath.section==0) {
            if(todayList.count == 0) {
                let noneLabel = UILabel()
                noneLabel.frame = CGRect(x: 0, y: CGFloat(10), width: cell.frame.width, height: cell.frame.height)
                noneLabel.font = UIFont.italicSystemFont(ofSize: 20)
                noneLabel.textColor = UIColor.white
                noneLabel.text = "    None"
                cell.addSubview(noneLabel)
            } else {
                let tupl = todayList[indexPath.row]
                let padding = CGFloat(15)
                
                let nameLabel = UILabel()
                nameLabel.frame = CGRect(x: padding, y: padding, width: 0, height: 0)
                nameLabel.text = tupl.0
                nameLabel.textColor = UIColor.white
                nameLabel.font = UIFont.systemFont(ofSize: 20)
                nameLabel.sizeToFit()
                cell.addSubview(nameLabel)
                
                let nameLabelHeight = nameLabel.frame.height
                let nameLabelWidth = nameLabel.frame.width
                let eventLabel = UILabel()
                eventLabel.frame = CGRect(x: padding, y: padding+nameLabelHeight, width: 0, height: 0)
                eventLabel.text = tupl.2
                eventLabel.textColor = UIColor.white
                eventLabel.font = UIFont.systemFont(ofSize: 12)
                eventLabel.sizeToFit()
                cell.addSubview(eventLabel)
                
                let moreImageView = UIImageView(image: UIImage(named: "icon5"))
                cell.accessoryView = moreImageView
            }
        } else {
            let monthLabel = UILabel()
            monthLabel.frame = CGRect(x: 0, y: 0, width: 50, height: cell.frame.height)
            monthLabel.textAlignment = .center
            monthLabel.font = UIFont.systemFont(ofSize: 18)
            monthLabel.text = String(indexPath.row+1)
            monthLabel.addBorder(toSide: .Right, withColor: UIColor.white.cgColor, andThickness: 1)
            monthLabel.textColor = UIColor.white
            
            cell.addSubview(monthLabel)
            
            let numberLabel = UILabel()
            numberLabel.frame = CGRect(x: 70, y: 0, width: cell.frame.width-70, height: cell.frame.height)
            numberLabel.textAlignment = .left
            numberLabel.font = UIFont.systemFont(ofSize: 14)
            numberLabel.textColor = UIColor.white
            let tuplLst = findTupl(section: indexPath.section, row: indexPath.row)
            if(tuplLst.count != 0) {
                numberLabel.text = String(tuplLst.count)+" reminders."
            }
            
            cell.addSubview(numberLabel)
        }
        // Configure the cell...
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = MainViewHeaderCard()
        header.backgroundColor = UIColor.init(red: 0/255, green: 49/255, blue: 82/255, alpha: 1)
        header.titleLabel.textColor = UIColor.white
        
        let line = UIView()
        line.frame = CGRect(x: CGFloat(10), y: 0, width: self.tableView.frame.width-CGFloat(20), height: CGFloat(1))
        line.backgroundColor = UIColor.white
        header.addSubview(line)
        
        if(section==0) {
            header.titleLabel.text = "Today"
        } else {
            let monthLabel = UILabel()
            monthLabel.frame = CGRect(x: 5, y: 5, width: 100, height: 20)
            monthLabel.font = UIFont.systemFont(ofSize: 20)
            monthLabel.text = monthDict[section]
            monthLabel.textColor = UIColor.white
            
            header.addSubview(monthLabel)
        }
        
        return header

    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if(section==0) {
            return 50
        }
        return 40
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if(section==0) {
            return 20
        }
        return 0
    }
    
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = UIView()
        footer.backgroundColor = UIColor.init(red: 0/255, green: 49/255, blue: 82/255, alpha: 1)

        return footer
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.section==0) {
            if(todayList.count == 0) {
                return 50
            } else {
                return 60
            }
        } else {
            return 60
        }
    }
    
    func findTupl(section: Int, row: Int) -> [(String,String,String,Date,Bool)] {
        let month = monthDict[section]
        let day = row+1
        
        var tuplLst: [(String,String,String,Date,Bool)] = []
        for tempTupl in dateTuplList {
            let tuplMonth = tempTupl.1
            let tuplDay = tempTupl.2
            if(month==tuplMonth && day==tuplDay) {
                tuplLst.append(tempTupl.4)
            }
        }

        return tuplLst
    }
    
    /*
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
    */
    
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
