//
//  SecondAddingViewController.swift
//  Remind
//
//  Created by Daniel Kim on 1/26/20.
//  Copyright © 2020 Daniel Kim. All rights reserved.
//

import UIKit

class SecondAddingViewController: UIViewController {
    
    var annualButtonState = true

    @IBOutlet var annualButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        annualButton.backgroundColor = UIColor.black
        annualButton.layer.borderColor = UIColor.black.cgColor
        annualButton.layer.borderWidth = 1
        annualButton.layer.roundCorners(radius: 10)

        // Do any additional setup after loading the view.
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
