//
//  Card.swift
//  Remind
//
//  Created by Daniel Kim on 1/26/20.
//  Copyright © 2020 Daniel Kim. All rights reserved.
//

import Foundation
import UIKit

class MainCard: UIView {
    
    let iconImageView = UIImageView()
    let titleView = UIView()
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
        
        titleView.layer.borderWidth = 1
        
        let padding = CGFloat(10)
        let imageHeight = titleViewHeight - padding * 2
        let imageWidth = imageHeight
        iconImageView.frame = CGRect(x: padding, y: padding, width: imageWidth, height: imageHeight)
        
        let labelWidth = self.frame.width - padding*2 - imageWidth
        let labelHeight = titleViewHeight
        titleLabel.frame = CGRect(x: padding+imageWidth+padding, y: 0, width: labelWidth, height: labelHeight)
        titleLabel.font = UIFont.boldSystemFont(ofSize: 25)
        titleLabel.adjustsFontSizeToFitWidth = true
        
        titleLabel.layer.borderWidth = 1
        
        let infoWidth = self.frame.width
        let infoHeight = self.frame.height - labelHeight
        infoView.frame = CGRect(x: 0, y: labelHeight, width: infoWidth, height: infoHeight)
        infoView.layer.roundCorners(radius: 10)
        
        infoView.layer.borderWidth = 1
        
        
        self.addSubview(titleView)
        titleView.addSubview(iconImageView)
        titleView.addSubview(titleLabel)
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
