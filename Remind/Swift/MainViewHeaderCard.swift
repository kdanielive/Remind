//
//  Card.swift
//  Remind
//
//  Created by Daniel Kim on 1/26/20.
//  Copyright © 2020 Daniel Kim. All rights reserved.
//

import Foundation
import UIKit

class MainViewHeaderCard: UIView {
    
    let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        // setupView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupView()
    }
    
    func setupView() {
        // Setting up the basic setting of the content view
        
        let padding = CGFloat(5)
        let labelWidth = CGFloat(0)
        let labelHeight = CGFloat(40)
        titleLabel.frame = CGRect(x: padding, y: padding, width: labelWidth, height: labelHeight)
        titleLabel.font = UIFont.boldSystemFont(ofSize: 25)
        titleLabel.sizeToFit()
        titleLabel.addBorder(toSide: .Bottom, withColor: UIColor.black.cgColor, andThickness: 1)
        titleLabel.adjustsFontSizeToFitWidth = true
        
        self.addSubview(titleLabel)
    }
}
