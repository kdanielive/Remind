//
//  Card.swift
//  Remind
//
//  Created by Daniel Kim on 1/26/20.
//  Copyright © 2020 Daniel Kim. All rights reserved.
//

import Foundation
import UIKit

class MainViewPersonCard: UIView {
    
    let titleLabel = UILabel()
    
    let infoView = UIView()
    let nameLabel = UILabel()
    let eventLabel = UILabel()
    let dateLabel = UILabel()
    let additionalLabel = UILabel()
    
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
        let padding = CGFloat(10)
        
        let labelWidth = CGFloat(0)
        let labelHeight = CGFloat(50)
        titleLabel.frame = CGRect(x: padding, y: padding, width: labelWidth, height: labelHeight)
        titleLabel.font = UIFont.boldSystemFont(ofSize: 22)
        titleLabel.addBorder(toSide: .Bottom, withColor: UIColor.red.cgColor, andThickness: 1)
        titleLabel.sizeToFit()
        titleLabel.adjustsFontSizeToFitWidth = true
        
        let infoWidth = self.frame.width
        let infoHeight = self.frame.height - labelHeight
        infoView.frame = CGRect(x: 0, y: labelHeight, width: infoWidth, height: infoHeight)
        infoView.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 10)
        
        //infoView.layer.borderWidth = 1
        
        let nameWidth = self.frame.width - padding*2
        let nameHeight = CGFloat(40)
        nameLabel.frame = CGRect(x: padding, y: padding, width: nameWidth, height: nameHeight)
        nameLabel.font = UIFont.boldSystemFont(ofSize: 20)
        nameLabel.adjustsFontSizeToFitWidth = true
        
        //nameLabel.layer.borderWidth = 1
        
        let eventWidth = nameWidth/2
        let eventHeight = nameHeight
        eventLabel.frame = CGRect(x: padding, y: padding*2+nameHeight, width: eventWidth, height: eventHeight)
        eventLabel.font = UIFont.systemFont(ofSize: 20)
        
        let dateWidth = eventWidth
        let dateHeight = eventHeight
        dateLabel.frame = CGRect(x: padding+eventWidth, y: padding*2+nameHeight, width: dateWidth, height: dateHeight)
        dateLabel.font = UIFont.systemFont(ofSize: 20)
        
        //eventLabel.layer.borderWidth = 1
        //dateLabel.layer.borderWidth = 1
        
        //Setting Colors
        
        self.addSubview(titleLabel)
        self.addSubview(infoView)
        infoView.addSubview(nameLabel)
        infoView.addSubview(eventLabel)
        infoView.addSubview(dateLabel)
        //infoView.addSubview(additionalLabel)
    }
}

extension CALayer {
    func addShadow() {
        self.shadowOffset = .zero
        self.shadowOpacity = 1
        self.shadowRadius = 12
        self.shadowColor = UIColor.black.cgColor
        self.masksToBounds = false
        if cornerRadius != 0 {
            addShadowWithRoundedCorners()
        }
    }
    func roundCorners(radius: CGFloat) {
        self.cornerRadius = radius
        if shadowOpacity != 0 {
            addShadowWithRoundedCorners()
        }
    }
    private func addShadowWithRoundedCorners() {
        if let contents = self.contents {
            masksToBounds = false
            sublayers?.filter{ $0.frame.equalTo(self.bounds) }
                .forEach{ $0.roundCorners(radius: self.cornerRadius) }
            self.contents = nil
            if let sublayer = sublayers?.first,
                sublayer.name == "hi" {
                
                sublayer.removeFromSuperlayer()
            }
            let contentLayer = CALayer()
            contentLayer.name = "hi"
            contentLayer.contents = contents
            contentLayer.frame = bounds
            contentLayer.cornerRadius = cornerRadius
            contentLayer.masksToBounds = true
            insertSublayer(contentLayer, at: 0)
        }
    }
}

extension UIView {
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
