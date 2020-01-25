//
//  Card.swift
//  Remind
//
//  Created by Daniel Kim on 1/26/20.
//  Copyright © 2020 Daniel Kim. All rights reserved.
//

import Foundation
import UIKit

class Card: UIView {
    
    let titleLabel = UILabel()
    let infoView = UIView()
    
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
        
        let padding = CGFloat(10)
        let labelWidth = self.frame.width - padding*4
        let labelHeight = CGFloat(60)
        titleLabel.frame = CGRect(x: padding*2, y: 0, width: labelWidth, height: labelHeight)
        titleLabel.font = UIFont.boldSystemFont(ofSize: 25)
        titleLabel.adjustsFontSizeToFitWidth = true
        
        titleLabel.layer.borderWidth = 1
        
        let infoWidth = self.frame.width
        let infoHeight = self.frame.height - labelHeight
        infoView.frame = CGRect(x: 0, y: labelHeight, width: infoWidth, height: infoHeight)
        infoView.layer.roundCorners(radius: 10)
        
        infoView.layer.borderWidth = 1
        
        self.addSubview(titleLabel)
        self.addSubview(infoView)
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
