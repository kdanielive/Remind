//
//  MainViewActionCard.swift
//  Remind
//
//  Created by Daniel Kim on 1/26/20.
//  Copyright © 2020 Daniel Kim. All rights reserved.
//

import Foundation
import UIKit

class MainViewActionCard: UIView {
    
    let titleView = UIView()
    let iconImageView = UIImageView()
    let titleLabel = UILabel()
    
    let infoView = UIView()
    let nameLabel = UILabel()
    
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
        self.layer.roundCorners(radius: 10)
        
        self.layer.borderWidth = 2
        
        let titleViewWidth = self.frame.width
        let titleViewHeight = CGFloat(60)
        titleView.frame = CGRect(x: 0, y: 0, width: titleViewWidth, height: titleViewHeight)
        titleView.roundCorners(corners: [UIRectCorner.topLeft,UIRectCorner.topRight], radius: 10)
                
        let padding = CGFloat(10)
        let imageHeight = titleViewHeight - padding * 2
        let imageWidth = imageHeight
        iconImageView.frame = CGRect(x: padding, y: padding, width: imageWidth, height: imageHeight)
        
        let labelWidth = self.frame.width - padding*2 - imageWidth
        let labelHeight = titleViewHeight
        titleLabel.frame = CGRect(x: padding+imageWidth+padding, y: 0, width: labelWidth, height: labelHeight)
        titleLabel.font = UIFont.boldSystemFont(ofSize: 25)
        titleLabel.adjustsFontSizeToFitWidth = true
        
        let infoWidth = self.frame.width
        let infoHeight = self.frame.height - labelHeight
        infoView.frame = CGRect(x: 0, y: labelHeight, width: infoWidth, height: infoHeight)
        infoView.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 10)
        
        //infoView.layer.borderWidth = 1
        
        let nameWidth = self.frame.width - padding*2
        let nameHeight = CGFloat(50)
        nameLabel.frame = CGRect(x: padding, y: padding, width: nameWidth, height: nameHeight)
        nameLabel.font = UIFont.boldSystemFont(ofSize: 20)
        nameLabel.adjustsFontSizeToFitWidth = true
        
        //nameLabel.layer.borderWidth = 1
        
        //Setting Colors
        titleView.backgroundColor = UIColor.black
        infoView.backgroundColor = UIColor.init(red: 0/255, green: 49/255, blue: 82/255, alpha: 1)
        
        titleLabel.textColor = UIColor.white
        nameLabel.textColor = UIColor.white
        
        self.addSubview(titleView)
        titleView.addSubview(iconImageView)
        titleView.addSubview(titleLabel)
        self.addSubview(infoView)
        infoView.addSubview(nameLabel)
    }
}
